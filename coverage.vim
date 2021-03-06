"hi HitLine ctermbg=Cyan guibg=Cyan
"hi MissLine ctermbg=Magenta guibg=Magenta
hi HitSign ctermfg=Green cterm=bold gui=bold guifg=Green
hi MissSign ctermfg=Red cterm=bold gui=bold guifg=Red

sign define hit  linehl=HitLine  texthl=HitSign  text=>>
sign define miss linehl=MissLine texthl=MissSign text=:(

"Generated by simplecov-vim
let s:coverage = {'corundum.rb': [[1, 6, 7, 9, 10, 36, 40, 41, 42, 43, 46, 47, 49, 51, 52, 53, 55, 56, 57, 59, 60, 65, 66, 67, 68, 69, 72, 73, 74, 81, 84, 85, 86, 88, 89, 91, 92, 94, 99, 100, 102, 107, 108, 109, 114, 115, 116],[75, 76, 78, 79, 95, 96, 103, 104, 110, 111, 117, 118]], 'corundum/configurable.rb': [[3, 4, 5, 8, 9, 10, 11, 14, 15, 16, 19, 20, 21, 23, 26, 27, 28, 29, 30, 33, 34, 35, 37, 40, 41, 42, 43, 44, 47, 48, 49, 51],[]], 'corundum/email.rb': [[1, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 18, 38, 39, 40, 41, 42, 58],[19, 20, 21, 22, 23, 28, 31, 32, 33, 35, 43, 45, 47, 48, 49, 50, 51, 53, 54, 59, 61, 62, 63, 64, 65, 66, 70, 72]], 'corundum/gem_building.rb': [[1, 3, 4, 5, 6, 7, 8, 11, 12, 14, 15, 16, 17, 18, 21, 22, 26],[]], 'corundum/gemcutter.rb': [[1, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 15, 18, 19, 22, 23, 28, 32, 37, 43, 50, 51, 52, 61, 70, 72, 84, 94, 95, 101, 103, 104],[24, 25, 29, 33, 34, 38, 39, 44, 45, 46, 47, 53, 54, 55, 56, 57, 62, 63, 64, 65, 66, 73, 74, 75, 76, 77, 79, 85, 86, 87, 88, 89, 90, 96, 97, 98, 99]], 'corundum/gemspec_sanity.rb': [[1, 3, 4, 5, 9, 13],[6, 10, 14, 15, 16, 17, 20, 24]], 'corundum/rspec.rb': [[1, 2, 4, 9, 10, 11, 14, 15, 30, 31, 34, 36, 37, 38, 43, 54, 62, 67, 68, 69, 70, 73, 74, 75, 77, 79, 98, 99, 100, 101, 103, 104, 105, 106, 107, 110, 111, 112, 113, 114, 115, 121, 125, 129, 130, 132],[44, 45, 46, 47, 48, 49, 51, 55, 56, 57, 58, 59, 63, 64, 80, 81, 82, 84, 85, 86, 87, 89, 90, 92, 116, 122, 123]], 'corundum/rubyforge.rb': [[1, 7, 8, 9, 13, 20],[10, 14, 15, 16, 17, 21, 22, 24, 25, 26, 27, 28, 29, 30, 31, 34, 35, 36, 37, 38, 41, 42, 43, 44, 45, 46, 47, 49, 50, 51, 53, 54]], 'corundum/simplecov.rb': [[1, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 15, 16, 18, 22, 23, 24, 25, 28, 29, 30, 33, 39, 47, 56, 57, 58, 60, 66, 70, 71, 78, 80, 81, 85, 97, 117, 119],[19, 34, 35, 40, 41, 42, 44, 48, 49, 50, 51, 52, 53, 61, 62, 63, 67, 72, 73, 75, 82, 86, 88, 90, 91, 93, 94, 98, 100, 102, 104, 106, 108, 109, 110, 113]], 'corundum/tasklib.rb': [[1, 2, 3, 5, 6, 7, 9, 12, 15, 16, 17, 18, 19, 21, 22, 27, 28, 33, 34, 37, 41, 45, 46, 48, 50, 52, 54],[42]], 'corundum/tasklibs.rb': [[1, 2, 3, 4, 5, 6, 7, 8, 9],[]], 'corundum/version_control.rb': [[1, 3, 4, 5, 6, 9, 10, 11, 12, 13, 16, 17, 18, 19, 20, 21, 22, 23, 26, 27, 28, 29, 31],[]], 'corundum/version_control/git.rb': [[1, 3, 4, 5, 10, 15, 31, 38],[6, 7, 11, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 28, 32, 33, 34, 35, 39, 41, 42, 43, 44, 45, 49, 50, 51, 52, 56, 57, 58, 59, 63, 64, 65, 66, 69, 70, 71, 75, 76, 77, 78, 81, 82, 84, 85, 87, 88, 91, 93, 94, 97, 98, 101]], 'corundum/version_control/monotone.rb': [[1, 2, 4, 5, 6, 7, 8, 11, 12, 15, 16, 17, 18, 19, 20, 21, 22, 23, 26, 29, 30, 31, 32, 33, 35, 36, 37, 38, 40, 42, 44, 45, 52, 53, 55, 58, 59, 60, 61, 62, 64, 65, 67, 69, 71, 72, 74, 77, 80, 81, 84, 85, 86, 87, 88, 93, 106, 107, 109, 110, 117, 125, 133, 147, 151, 155],[24, 50, 94, 95, 96, 97, 98, 99, 101, 103, 111, 112, 113, 118, 119, 120, 121, 126, 127, 128, 129, 134, 135, 136, 137, 140, 141, 142, 143, 148, 152]], 'corundum/yardoc.rb': [[1, 2, 4, 5, 6, 7, 10, 11, 12, 13, 16, 17, 19, 20, 21, 22, 23, 24, 25, 29, 30],[]],  }

let s:generatedTime = 1325210335

function! BestCoverage(coverageForName)
  let matchBadness = strlen(a:coverageForName)
  for filename in keys(s:coverage)
    let matchQuality = match(a:coverageForName, filename . "$")
    if (matchQuality >= 0 && matchQuality < matchBadness)
      let found = filename
    endif
  endfor

  if exists("found")
    return s:coverage[found]
  else
    echom "No coverage recorded for " . a:coverageForName
    return [[],[]]
  endif
endfunction

let s:signs = {}
let s:signIndex = 1

function! s:CoverageSigns(filename)
  let [hits,misses] = BestCoverage(a:filename)

  if (getftime(a:filename) > s:generatedTime)
    echom "File is newer than coverage report which was generated at " . strftime("%c", s:generatedTime)
  endif

  if (! exists("s:signs['".a:filename."']"))
    let s:signs[a:filename] = []
  endif

  for hit in hits
    let id = s:signIndex
    let s:signIndex += 1
    let s:signs[a:filename] += [id]
    exe ":sign place ". id ." line=".hit." name=hit  file=" . a:filename
  endfor

  for miss in misses
    let id = s:signIndex
    let s:signIndex += 1
    let s:signs[a:filename] += [id]
    exe ":sign place ".id." line=".miss." name=miss file=" . a:filename
  endfor
endfunction

function! s:ClearCoverageSigns(filename)
  if(exists("s:signs['". a:filename."']"))
    for signId in s:signs[a:filename]
      exe ":sign unplace ".signId
    endfor
    let s:signs[a:filename] = []
  endif
endfunction

let s:filename = expand("<sfile>")
function! s:AutocommandUncov(sourced)
  if(a:sourced == s:filename)
    call s:ClearCoverageSigns(expand("%:p"))
  endif
endfunction

command! -nargs=0 Cov call s:CoverageSigns(expand("%:p"))
command! -nargs=0 Uncov call s:ClearCoverageSigns(expand("%:p"))

augroup SimpleCov
  au!
  exe "au SourcePre ".expand("<sfile>:t")." call s:AutocommandUncov(expand('<afile>:p'))"
augroup end

Cov
