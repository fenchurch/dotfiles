if exists("did_load_filetypes")
  finish
endif
function! IsReadOnly()
    if &readonly
        hi FoldColumn ctermbg=1 ctermfg=233
    else
        hi clear FoldColumn 
    endif
endfunction

function! Sh_folds()
  let l:line = getline(a:lnum)
  let l:pnum = a:lnum - 1
  if  l:line =~ '^\s*function\s\+\S\+\s\+[(.*)]*\s*{\s*$'
    return "a1"
  endif
  if l:line =~ '^\s*\#.*'
    return "="
  endif
  if l:line =~ '^\s*}\s*$'
    return "s1"
  endif
  if foldlevel(l:pnum) <= 0 
    return "="
  endif
  return "NF"
endfunction

augroup filetypedetect
    au BufRead,BufNewFile * let Comment="#" | let EndComment=""
    au BufRead,BufNewFile *.inc,*.ihtml,*.html,*.tpl,*.class,*.xml,*.plist let Comment="<!-- " | let EndComment=" -->"
    au BufRead,BufNewFile *.sh,*.pl,*.tcl,*.py,*.zsh* let Comment="#" | let EndComment="" 
    au BufRead,BufNewFile *.cc,*.cxx,*.less,*.php,*.js let Comment="//" | let EndComment=""
    au BufRead,BufNewFile *.c,*.h,*.css let Comment="/*" | let EndComment="*/"
    au BufRead,BufNewFile *.vim let Comment="\"" | let EndComment=""
    au BufNewFile,BufRead *.conf* set filetype=conf | let Comment="#" | let EndComment=""
    au BufReadPost * call IsReadOnly() 
    
    function! CommentLines()
        exe ":s@^@".g:Comment."@g"
        exe ":s@$@".g:EndComment."@g"
    endfunction
    function! UncommentLines()
        exe ":s@^".g:Comment."@@g"
        exe ":s@$".g:EndComment."@@g"
    endfunction

augroup END
