if exists("did_load_filetypes")
  finish
endif
function! IsReadOnly()
    if ( &readonly && &ft!='help' )
        hi FoldColumn ctermbg=1 ctermfg=233
        hi StatusLine ctermbg=1 ctermfg
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

function! Pound_comment() 
    let g:Comment="#"
    let g:EndComment=""
endfunction
function! Tag_comment()
    let g:Comment="<!-- "
    let g:EndComment=" -->"
endfunction
function! Slash_comment()
    let g:Comment="//"
    let g:EndComment=""
endfunction
function! SlashStar_comment()
    let g:Comment="/*"
    let g:EndComment="*/"
endfunction
function! Quote_comment()
    let g:Comment="\""
    let g:EndComment=""
endfunction

augroup filetypedetect
    "default    
    au BufRead,BufNewFile * call Pound_comment() 
    "specific filetypes
    au FileType sh call Pound_comment() | set foldmethod=expr | set foldexpr=Sh_folds
    au FileType php,javascript,less call Slash_comment()
    au FileType c,cpp,css, call SlashStar_comment()
    au FileType html,smarty,stata,xml,plist call Tag_comment()
    au FileType vim call Quote_comment()
    au FileType * call IsReadOnly() 
    au BufRead,BufNewFile */.functions,*/.aliases,*/.bash* set ft=sh

    function! CommentLines()
        exe ":s@^@".g:Comment."@g"
        exe ":s@$@".g:EndComment."@g"
    endfunction
    function! UncommentLines()
        exe ":s@^".g:Comment."@@g"
        exe ":s@".g:EndComment."$@@g"
    endfunction
    vmap //// :call CommentLines()<CR>gv
    vmap ???? :call UncommentLines()<CR>gv
augroup END
