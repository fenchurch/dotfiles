"--------------------------------------------------------------------------------
"
" Init
"--------------------------------------------------------------------------------
"vim not vi
set nocompatible
" shows what you are typing as a command
set showcmd
" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax on 
set grepprg=grep\ -nH\ $*

"
"vundle bundles
set rtp+=~/.vim/bundle/Vundle.vim
source ~/.vim/vundle.vim
"
"-------------------------------------------------------------------------------
"    File Ops
"-------------------------------------------------------------------------------
set nobackup                                    "no backup files
set nowritebackup                               "only in case you don't want a backup file while editing
set noswapfile                                  "no swap files
"set backup
set backupdir=/tmp
set directory=/tmp
set undodir=/tmp
set autochdir                                   "chdir on file open
set autoread
"-------------------------------------------------------------------------------
"    Options
"-------------------------------------------------------------------------------
set mouse=a
set showmatch                                   " Braces,quotes,parenthesis
set autoindent                                  " Indent automatically 
set expandtab                                   " Spaces>Tabs 
set smarttab
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start                  " backspace across lines
set wildmenu
set wildmode=list:longest,full                  " Cool tab completion stuff
set number                                      " Line Numbers
set ignorecase
set smartcase

set incsearch                                   " Incremental searching
set hlsearch                                    " Highlight search

set nohidden                                    " When I close a tab, remove the buffer
set laststatus=2                                "Status line folder/file[mod] (fileformat){syntax} [x,y] {page %}
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
set clipboard=unnamed                           " Yank to system clipboard

"-------------------------------------------------------------------------------
"    Folding
"-------------------------------------------------------------------------------

set fillchars=fold:-                            " foldcolumn stuff
set foldcolumn=2
set foldenable
"set foldmethod=syntax
set foldlevel=99

"--------------------------------------------------------------------------------
"    Appearance
"--------------------------------------------------------------------------------
colorscheme solarized
set background=dark

if has("gui_running")
    " Remove Toolbar
    set guioptions-=T
    set gfn=Inconsolata:h14
    set transparency=2
else
"its what UL is
    nmap f w
endif

"   Change cursorline in editmode
autocmd InsertEnter,InsertLeave * set cul!    
autocmd InsertEnter * hi CursorLine term=underline gui=underline cterm=underline 
autocmd InsertLeave * hi CursorLine term=none gui=none cterm=none ctermbg=0 
 
"--------------------------------------------------------------------------------
"    Mappings
"--------------------------------------------------------------------------------
"dup this line
nmap <D-P> ^v$y<esc>Pj
nmap <C-P> <D-P> 
nmap <D-V> <D-P> 
nmap <C-V> <D-P>
"map command left and right for nongui 
nmap <Char-0x01> ^
nmap <Char-0x05> $
imap <Char-0x01> <Esc>^i
imap <Char-0x05> <Esc>$i
"remap jj to escape in insert mode
imap jj <Esc>
vmap JJ <Esc>
nmap JJ <Nop>
"map capslock to F6 with karibener and F6 to insert/normal mode
imap <F6> <Esc>l
nmap <F6> i
vmap <F6> <Esc>i
cmap <F6> <Esc>
omap <F6> <Esc>
nmap //// :noh<CR>
"indenting, normal, visual and inserttoggle
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
vmap << <gv
vmap >> >gv
imap <D-[> <Esc><<<i>
imap <D-]> <Esc>>><i>
"commenting: Using filetype to assign before / after comment tags
vmap //// :call CommentLines()<CR>gv
vmap ???? :call UncommentLines()<CR>gv

"command+s
map <D-s> <Esc>:w<CR>
imap <D-s> <Esc>:w<CR>i
map ß <D-s>
imap ß <D-s>
"source the current script
nmap <D-r> <Esc>:w<CR>:! [ \! -x "%:p" ] && chmod +x "%:p"; "%:p"<CR>
imap <D-r> <Esc>:w<CR>:! "%:p"<CR>
"map to F5 for cli, map terminal command+r to F5 ( ^[ [15~ )
nmap <F5> <D-r>
imap <F5> <D-r>
"run current line in shell
nmap <D-R> ^y$:! <C-r>"<CR>
"map to S+F5 for cli, map terminal command+R to S+F5 (^[ [15;2~ )
nmap <S-F5> <D-R>
imap <S-F5> <D-R>
"run selected text in shell
vmap <D-r> y:! <C-r>"<CR>
vmap <F5> <D-r>
"echo selected text in shell
vmap <D-R> y:! echo <C-r>"<CR>
vmap <S-F5> <D-R>
"surround words 
vmap ' xa'<C-r>"'
vmap " xa"<C-r>""
vmap ( xa(<C-r>")
vmap < xa<<C-r>">
nmap <D-'> ciW'<C-r>"'
nmap <D-"> ciW"<C-r>""
nmap <D-(> ciW(<C-r>")
nmap <D-<> ciW<<C-r>">

nnoremap <D-F1> :split $MYVIMRC<CR>
nnoremap <S-D-F1> :source $MYVIMRC<CR>

"folding
nnoremap <space> za
nnoremap <S-space> zM
vnoremap <space> zO
"run this line 
nmap * ^v$y<esc>:<c-r>"<BS><CR>
imap <c-8> <esc>^v$y<esc>:<c-r>"<BS><CR>
"--------------------------------------------------------------------------------
"   Plugin Settings / Mappings 
"--------------------------------------------------------------------------------
"Snippets
let g:snips_author = 'Rusty Gibbs'
let g:snips_authorsite = 'http://www.wickedidol.com'
let g:snips_authorgit = 'https://github.com/fenchurch/'
"compile less to css
nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space> "
"Nerdree window
nmap @ :NERDTree<CR>
"Sparkup Execute
let g:sparkupExecuteMapping = '<c-CR>'

let php_folding = 1        "Set PHP folding of classes and functions.
let php_htmlInStrings = 1  "Syntax highlight HTML code inside PHP strings.
let php_sql_query = 1      "Syntax highlight SQL code inside PHP strings.
let php_noShortTags = 1    "Disable PHP short tags.

"enable status line always
set laststatus=2
let g:AF_foldwidth="full"
