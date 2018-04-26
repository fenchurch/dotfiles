if exists("did_load_filetypes")
  finish
endif
function! IsReadOnly()
    if ( &readonly && &ft!='help' )
        hi FoldColumn ctermbg=1 ctermfg=233
        hi StatusLine ctermbg=1 ctermfg
    else
    endif
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
    au FileType sh call Pound_comment()
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
