require 'corundum/tasklib'
require 'mattock/task'

module Corundum
  class GitTask < Mattock::CommandTask
    setting(:subcommand)
    setting(:arguments, [])

    def command
      Mattock::CommandLine.new("git", "--no-pager") do |cmd|
        cmd.options << subcommand
        arguments.each do |arg|
          cmd.options += [*arg]
        end
      end
    end
  end

  class InDirCommandTask < Mattock::CommandTask
    setting :target_dir

    def default_configuration(parent)
      parent.copy_settings_to(self)
    end

    def needed?
      FileUtils.cd target_dir do
        super
      end
    end

    def action
      FileUtils.cd target_dir do
        super
      end
    end
  end

  class GithubPages < TaskLib
    default_namespace :publish_docs

    setting(:target_dir, "gh-pages")
    setting(:source_dir)

    nil_fields :repo_dir

    def branch
      "gh-pages"
    end

    def default_configuration(doc_gen)
      self.source_dir = doc_gen.target_dir
    end

    def resolve_configuration
      self.repo_dir ||= File::join(target_dir, ".git")
    end

    def git_command(*args)
      Mattock::CommandLine.new("git", "--no-pager") do |cmd|
        args.each do |arg|
          cmd.options += [*arg]
        end
      end
    end

    def git(*args)
      result = git_command(*args).run
      result.must_succeed!
      result.stdout.lines.to_a
    end

    def define
      in_namespace do
        InDirCommandTask.new(self) do |t|
          t.task_name = :on_branch
          t.verify_command = Mattock::PipelineChain.new do |chain|
            chain.add git_command(%w{branch})
            chain.add Mattock::CommandLine.new("grep", "-q", "'^[*] #{branch}'")
          end
          t.command = Mattock::PrereqChain.new do |chain|
            chain.add git_command("checkout", branch)
          end
        end

        file repo_dir do
          fail "Refusing to clobber existing #{target_dir}" if File.exists?(target_dir)

          url = git("config", "--get", "remote.origin.url").first

          git("clone", url.chomp, "-b", branch, target_dir)
          Mattock::CommandLine.new("rm", File::join(repo_dir, "hooks", "*")).must_succeed!
        end

        task :pull => [repo_dir, :on_branch] do
          FileUtils.cd target_dir do
            git("pull")
          end
        end

        InDirCommandTask.new(self) do |t|
          t.task_name = :setup
          t.verify_command = Mattock::PipelineChain.new do |chain|
            chain.add git_command(%w{branch -r})
            chain.add Mattock::CommandLine.new("grep", "-q", branch)
          end
          t.command = Mattock::PrereqChain.new do |cmd|
            cmd.add git_command("checkout", "-b", branch)
            cmd.add Mattock::CommandLine.new("rm -rf *")
            cmd.add git_command(%w{commit -a -m} + ["'Creating pages'"])
            cmd.add git_command("push", "origin", branch)
            cmd.add git_command("branch", "--set-upstream", branch, "origin/" + branch)
          end
        end
        task :setup => repo_dir

        task :pre_publish => [repo_dir, :setup, :pull]

        task :clobber_target => :on_branch do
          Mattock::CommandLine.new(*%w{rm -rf}) do |cmd|
            cmd.options << target_dir + "/*"
          end.must_succeed!
        end

        task :assemble_docs => [:pre_publish, :clobber_target] do
          Mattock::CommandLine.new(*%w{cp -a}) do |cmd|
            cmd.options << source_dir + "/*"
            cmd.options << target_dir
          end.must_succeed!
        end

        task :publish => [:assemble_docs, :on_branch] do
          FileUtils.cd target_dir do
            git("add", ".")
            git("commit", "-m", "'Corundum auto-publish'")
            git("push", "origin", branch)
          end
        end
      end

      desc "Push documentation files to Github Pages"
      task root_task => self[:publish]
    end
  end
end
