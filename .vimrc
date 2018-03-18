set nocompatible        " must be the first line
execute pathogen#infect()

set viminfo+=n~/.vim/viminfo
set encoding=utf-8
set hlsearch
set nohidden " close tab closes buffer
set autochdir
set expandtab
set softtabstop=2
set tabstop=2
set foldmethod=marker
set ruler
set bs=2
set sw=2
set background=dark
set backspace=indent,eol,start
set laststatus=2
set highlight=sb
set nojoinspaces
set t_kb=       " Nested screens change $TERM and render delete useles (ctrl-v + Backspace)
set scrolloff=3
set hidden
set history=1000
set ignorecase
set smartcase
set ttymouse=xterm2 " mouse support
set ttyfast
"set grepprg=grep\ -rsin\ $*\ *
"set formatprg=par
set wildmode=longest,list,full
set wildmenu
set confirm
set shiftround    " round to 'shiftwidth' for "<<" and ">>"
filetype plugin on

let mapleader=","

" Disable the loading of hilighted matching parenthesis
let loaded_matchparen = 1

" This adjusts the title of tmux
set titleold=bash
set t_ts=k
set t_fs=\
set title
autocmd BufEnter * let &titlestring = expand("%:t")

" put cursor back where it was last time when re-opening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" settings for screenplay plugin
au BufRead,BufNewFile *.screenplay    set filetype=screenplay

" nuke all trailing space before a write
au BufWritePre * :%s/\s\+$//e

" lint python
au BufWritePost *.py call Flake8()

" omni autocompletions per-language
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP

" So that muttng temp files for composing email have syntax highlighting
au BufNewFile,BufRead muttng-*-\w\+ setf mail

syntax on

" Insert <Tab> or the 'complete' identifier, this is good.
function MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
         return "\<tab>"
    else
         return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

cmap Q<CR> q<CR>
cmap Q!<CR> q!<CR>
cmap Q1<CR> q!<CR>
cmap q1<CR> q!<CR>
cmap Wq<CR> wq<CR>
nmap W <Esc>:w<CR>
nmap X <Esc>:wq<CR>
nmap Q <Esc>:q<CR>

" for long lines
noremap j gj
noremap k gk

"  make <Backspace> act as <Delete> in Visual mode?
vmap <BS> x
"This changes the behavior of the . command to leave the cursor at the point where it was before editing started
nmap . .`[
nnoremap ; :
"map <C-J> <Esc>:%!python -m json.tool<CR>
map <C-j> <Esc>:% !jq '.'<CR>

abbreviate definately definitely
abbreviate oppurtunity opportunity
abbreviate alot a lot

" just fucking exit
map <F12> <Esc>:q!<CR>
imap <F12> <Esc>:q!<CR>
map <C-d> :q!<CR>
imap <C-d> <Esc>:q!<CR>


" Tab settings
nmap <C-t> :tabnew<CR>:e<space>
imap <C-t> <Esc>:tabnew<CR>:e<space>
nmap [1;2D :tabp<CR>
nmap [1;2C :tabn<CR>
imap [1;2D <Esc>:tabp<CR>
imap [1;2C <Esc>:tabn<CR>
set showtabline=2
set tabpagemax=500

" Format a whole paragraph nicely
nmap gb i!gb!<esc>gqip?!gb!<cr>df!

" open the quickfix window after doing a grep
autocmd QuickFixCmdPost *grep* cwindow

" For when you :grep something and you want to go through the changes
map <F8> <Esc>:cn<CR>
map <S-F8> <Esc>:cp<CR>

" size of preview window, eg git status
set previewheight=25
map <C-g> <Esc>:Gstatus<CR>
"map <C-G> :Dispatch! git stash ; git pull --rebase ; git push ; git stash pop<CR>

map <F5> :GitGutterToggle<cr>:set invnumber<cr>

map <Space> i

cmap w!! w !sudo tee % >/dev/null

colorscheme alexdefault

" yank into the system buffer
"map Y :'<,'>w !xclip -i -sel c<CR><CR>
nnoremap Y y$

" permanent undo history of files
let s:undoDir = "/home/alla/.vim/undo"
let &undodir=s:undoDir
set undofile

" keeps the current visual block selection active after changing indent with '<' or '>'
vmap > >gv
vmap < <gv

au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript

map <S-Up> <C-y>
map <S-Down> <C-e>
inoremap <S-Up> <C-x><C-y>
inoremap <S-Down> <C-x><C-e>
