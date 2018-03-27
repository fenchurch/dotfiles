"vim not vi
set nocompatible
" shows what you are typing as a command
set showcmd
" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*
source ~/.vim/vundle.vim
" mouse emulator 
set mouse=a
"backups in one place
set nobackup        "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
"set backup
set backupdir=/tmp
set directory=/tmp
set undodir=/tmp
"chdir on file open
set autochdir
"showmatch
set showmatch
" Who doesn't like autoindent?
set autoindent
" Spaces are better than a tab character
set expandtab
set smarttab
" Google Indentation (2)
set shiftwidth=4
set softtabstop=4
" backspace across lines
set backspace=indent,eol,start
" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full
" Line Numbers PWN!
set number
" Ignoring case is a fun trick
set ignorecase
" And so is Artificial Intellegence!
set smartcase
" Incremental searching is sexy
set incsearch
" Highlight things that we find with the search
set hlsearch
" When I close a tab, remove the buffer
set nohidden
"Status line 
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
"set the default shell
set clipboard=unnamed

set fillchars=fold:-
set foldcolumn=2
set foldenable
"set foldmethod=indent
set foldlevel=99
"--------------------------------------------------------------------------------
"    Coloring
"--------------------------------------------------------------------------------
" Favorite Color Scheme
colorscheme solarized
set background=dark

" colors & look
hi FoldColumn           ctermfg=2   ctermbg=233   cterm=none
hi Search               ctermfg=3   ctermbg=0     cterm=none
hi VertSplit            ctermfg=0   ctermbg=233   cterm=none
hi StatusLine           ctermfg=2   ctermbg=1   
hi StatusLineNC         ctermfg=1  ctermbg=233   cterm=none
hi LineNr               ctermbg=235
hi Comment              ctermfg=245 ctermbg=235 cterm=none

if has("gui_running")
    " Remove Toolbar
    set guioptions-=T
    set gfn=Inconsolata:h14
    set transparency=2
else
"its what UL is
    nmap f w
endif

set cul
set cul!
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

"source the current script
nmap <D-r> <Esc>:w<CR>:! "%:p"<CR>
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

"surround words with quotes
vmap ' xa'<C-r>"'
vmap " xa"<C-r>""
vmap ( xa(<C-r>")
nmap <D-'> ciW'<C-r>"'
nmap <D-"> ciW"<C-r>""
nmap <D-(> ciW(<C-r>")
nnoremap <D-F1> :split $MYVIMRC<CR>
nnoremap <S-D-F1> :source $MYVIMRC<CR>

"filetypes
au BufNewFile,BufRead *.zsh* set filetype=sh
let g:ragtag_global_maps = 1 

"folding
nnoremap <space> za
nnoremap <S-space> zM
vnoremap <space> zO

nnoremap <D-e> :edit<CR>
nnoremap <leader>e :edit<CR>
"run this line 
nmap * ^v$y<esc>:<c-r>"<BS><CR>
imap <c-8> <esc>^v$y<esc>:<c-r>"<BS><CR>

"--------------------------------------------------------------------------------
"    
"--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
"   Plugin Settings / Mappings 
"--------------------------------------------------------------------------------

"plugins
" surround word 
" surround to end of line
"vmap <D-lt> s<

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
