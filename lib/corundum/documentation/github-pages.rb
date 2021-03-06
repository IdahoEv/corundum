require 'mattock/tasklib'
require 'mattock/task'

module Corundum
  class GitTask < Mattock::Rake::CommandTask
    setting(:subcommand)
    setting(:arguments, [])

    def command
      cmd("git", "--no-pager") do |cmd|
        cmd.options << subcommand
        arguments.each do |arg|
          cmd.options += [*arg]
        end
      end
    end
  end

  class InDirCommandTask < Mattock::Rake::CommandTask
    setting :target_dir

    def default_configuration(parent)
      super
      parent.copy_settings_to(self)
    end

    def needed?
      return true unless File.directory? target_dir
      Dir.chdir target_dir do
        super
      end
    end

    def action(*args)
      Dir.chdir target_dir do
        super
      end
    end
  end

  class GithubPages < Mattock::CommandTaskLib
    default_namespace :publish_docs

    setting(:target_dir, "gh-pages")
    setting(:source_dir)
    setting(:docs_index)

    nil_fields :repo_dir

    def branch
      "gh-pages"
    end

    def default_configuration(doc_gen)
      super
      self.source_dir = doc_gen.target_dir
      self.docs_index = doc_gen.entry_point
    end

    def resolve_configuration
      super
      self.repo_dir ||= File::join(target_dir, ".git")
    end

    def git_command(*args)
      cmd("git", "--no-pager") do |cmd|
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
        file repo_dir do
          fail "Refusing to clobber existing #{target_dir}" if File.exists?(target_dir)

          url = git("config", "--get", "remote.origin.url").first
          git("clone", url.chomp, target_dir)
        end

        InDirCommandTask.define_task(self, :remote_branch => repo_dir) do |t|
          t.verify_command = git_command | cmd("grep", "-q", branch)
          t.command = git_command("checkout", "-b", branch) &
            cmd("rm -rf *") &
            git_command(%w{commit -a -m} + ["'Creating pages'"]) &
            git_command("push", "origin", branch) &
            git_command("branch", "--set-upstream", branch, "origin/" + branch)
        end

        InDirCommandTask.define_task(self, :local_branch => :remote_branch) do |t|
          t.verify_command = git_command(%w{branch}) | cmd("grep", "-q", "'#{branch}'")
          t.command = git_command("checkout", "-b", branch) &
            git_command("branch", "--set-upstream", branch, "origin/" + branch) &
            cmd("rm", "-f", '.git/index') &
            git_command("clean", "-fdx")
        end

        InDirCommandTask.define_task(self, :on_branch => [:remote_branch, :local_branch]) do |t|
          t.verify_command = git_command(%w{branch}) | cmd("grep", "-q", "'^[*] #{branch}'")
          t.command = git_command("checkout", branch)
        end

        task :pull => [repo_dir, :on_branch] do
          FileUtils.cd target_dir do
            git("pull", "-X", "ours")
          end
        end

        task :cleanup_repo => repo_dir do
          cmd("rm", "-f", File::join(repo_dir, "hooks", "*")).must_succeed!
          File::open(File::join(repo_dir, ".gitignore"), "w") do |file|
            file.write ".sw?"
          end
        end

        file target_dir => [:on_branch, :cleanup_repo]

        task :pre_publish => [repo_dir, target_dir]

        task :clobber_target => [:on_branch, :pull] do
          cmd(*%w{rm -rf}) do |cmd|
            cmd.options << target_dir + "/*"
          end.must_succeed!
        end

        task :assemble_docs => [docs_index, :pre_publish, :clobber_target] do
          cmd(*%w{cp -a}) do |cmd|
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
