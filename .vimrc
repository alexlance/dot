set nocompatible        " must be the first line
execute pathogen#infect()

set viminfo+=n~/.vim/viminfo
filetype on
filetype plugin on
syntax on
au BufRead,BufNewFile *.screenplay    set filetype=screenplay

autocmd BufWritePost */alloc/javascript/*.js :silent !(make cache > /dev/null)
autocmd BufWritePost */alloc/css/src/* :silent       !(make css > /dev/null)

set mouse=

if &diff
  colorscheme apprentice
endif

set encoding=utf-8
set hlsearch
set nohidden " close tab closes buffer
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
set noautochdir
set shiftround    " round to 'shiftwidth' for "<<" and ">>"
filetype plugin on

let mapleader=","

" quit/exit shortcuts fat fingers
cmap Q<CR> q<CR>
cmap Q!<CR> q!<CR>
cmap Q1<CR> q!<CR>
cmap q1<CR> q!<CR>
cmap Wq<CR> wq<CR>
map Y y$
map Q :q<CR>
map W :w<CR>

map <C-d> :q!<CR>
imap <C-d> <Esc>:q!<CR>
map <Space> i

function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
inoremap <Tab> <C-R>=SuperTab()<CR>

set ttyfast
noremap j gj
noremap k gk
let mapleader=","
nnoremap <leader>z zMzvzz
nnoremap K <nop>
nnoremap ; :
map <C-P> gqip
map <C-J> <Esc>:%!python -m json.tool<CR>

" omni autocompletions per-language
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType python set foldlevel=1
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP


set bs=2
set sw=2
set bg=dark
set laststatus=2
set highlight=sb
set ignorecase
set smartcase
set grepprg=grep\ -rsin\ $*\ *
set wildmode=longest,list,full
set wildmenu
set tabpagemax=500

map -- :%s/\s*$//g<CR>:noh<CR>

set scrolloff=0
set confirm
set nojoinspaces      " Use only one space after '.' when joining lines, instead of two
set shiftround        " round to 'shiftwidth' for "<<" and ">>"

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
" More attempt at fixing backspace when nested screens decide to change me $TERM and render delete useles
" note that the following value is made by hitting ctrl-v and then backspace...
" this remaps backspace to actualy BACKSPACE - not delete.
set t_kb=

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
nmap gb i!gb!<esc>gqip?!gb!<cr>df!
set ff=unix

if (v:version >= 700)
highlight SpellBad      ctermfg=Red         ctermbg=none
highlight SpellCap      ctermfg=Magenta     ctermbg=none
highlight SpellLocal    ctermfg=Magenta     ctermbg=none
highlight SpellRare     ctermfg=Magenta     ctermbg=none
endif

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
highlight TabLine       ctermfg=green ctermbg=black cterm=None
highlight TabLineSel    ctermfg=202
highlight TabLineFill   term=bold cterm=bold ctermbg=0

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

silent! colorscheme alexdefault

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
"autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=8
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
"
"set listchars=tab:>-,trail:-
"
" Go (golang) whitespace: real tabs.
autocmd FileType go setlocal sts=2 ts=2 sw=2 tabstop=2 noexpandtab nospell
autocmd FileType php setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell
autocmd FileType python setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell

set copyindent

" turn on backup
set backup
" " Set where to store backups
set backupdir=/home/alla/.vim/tmp/
set dir=/home/alla/.vim/tmp/
set viminfo+=n/home/alla/.vim/viminfo

" list char
highlight SpecialKey ctermfg=236
highlight Comment ctermfg=238
"highlight TabLineSel ctermfg=White
"highlight TabLine ctermfg=245
highlight LineNr ctermfg=236
set number
set cursorline
highlight cursorline cterm=none
highlight cursorlinenr ctermfg=130

map <F5> :GitGutterToggle<cr>:set invnumber<cr>

au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript

" compile and install go programs on save
autocmd BufWritePost *.go :GoInstall

set hlsearch
highlight Search ctermbg=162
nnoremap <CR> :noh<CR><CR>

set background=dark
colorscheme hybrid_material

au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript

map <S-Up> <C-y>
map <S-Down> <C-e>
inoremap <S-Up> <C-x><C-y>
inoremap <S-Down> <C-x><C-e>
