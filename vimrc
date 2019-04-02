set nocompatible        " must be the first line
execute pathogen#infect()

set viminfo+=n~/.vim/viminfo
filetype on
filetype plugin on

hi clear
if exists("syntax_on")
  syntax reset
endi
syntax on

set mouse=
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
set laststatus=0
set highlight=sb
set t_kb=       " Nested screens change $TERM and render delete useles (ctrl-v + Backspace)
set scrolloff=3
set hidden
set history=1000
set ignorecase
set smartcase
set ttymouse=xterm2 " mouse support
set ttyfast
set wildmode=longest,list,full
set wildmenu
set confirm
set noautochdir
set bg=dark
set grepprg=grep\ -rsin\ $*\ *
set nojoinspaces      " Use only one space after '.' when joining lines, instead of two
set shiftround        " round to 'shiftwidth' for "<<" and ">>"
"set nowrapscan        " don't wrap searches around to the top of the file
set iskeyword+=-      " make cw consider the dash character as a normal word char
set shortmess+=A      " get rid of 'a swap file already exists' messages
set ff=unix
set ttyfast
set foldmethod=indent
set foldnestmax=1
set showtabline=2
set tabpagemax=500
set tabline=
set copyindent
set backup
set backupdir=/home/alla/.vim/tmp/
set dir=/home/alla/.vim/tmp/

silent! colorscheme hybrid_material

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
" open all folds
noremap O maggvGzO`a

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

noremap j gj
noremap k gk
let mapleader=","
nnoremap <leader>z zMzvzz
nnoremap K <nop>
nnoremap ; :
map <C-P> gqip
map <C-J> <Esc>:%!python -m json.tool<CR>


" omni autocompletions per-language
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType go setlocal sts=2 ts=2 sw=2 tabstop=2 noexpandtab nospell
autocmd FileType php setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell
autocmd FileType python setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell
autocmd BufRead,BufNewFile *.screenplay    set filetype=screenplay
autocmd BufWritePost */alloc/javascript/*.js :silent !(make cache > /dev/null)
autocmd BufWritePost */alloc/css/src/* :silent       !(make css > /dev/null)

" Disable the loading of hilighted matching parenthesis
let loaded_matchparen = 1

" put cursor back where it was last time when re-opening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" nuke all trailing space before a write
au BufWritePre * :%s/\s\+$//e

" lint python
au BufWritePost *.py call Flake8()

" So that muttng temp files for composing email have syntax highlighting
au BufNewFile,BufRead muttng-*-\w\+ setf mail

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

if (v:version >= 700)
highlight SpellBad      ctermfg=Red         ctermbg=none
highlight SpellCap      ctermfg=Magenta     ctermbg=none
highlight SpellLocal    ctermfg=Magenta     ctermbg=none
highlight SpellRare     ctermfg=Magenta     ctermbg=none
endif

" Tab settings
nnoremap <C-t> :tabnew<CR>:e<space>
inoremap <C-t> <Esc>:tabnew<CR>:e<space>
nmap [1;2D :tabp<CR>
nmap [1;2C :tabn<CR>
imap [1;2D <Esc>:tabp<CR>
imap [1;2C <Esc>:tabn<CR>

" Format a whole paragraph nicely
nmap gb i!gb!<esc>gqip?!gb!<cr>df!
highlight TabLine       ctermfg=202 ctermbg=None cterm=None
highlight TabLineSel    ctermfg=white ctermbg=202
highlight TabLineFill   term=bold cterm=bold ctermbg=None

" open the quickfix window after doing a grep
autocmd QuickFixCmdPost *grep* cwindow

" For when you :grep something and you want to go through the changes
map <F8> <Esc>:cn<CR>
map <S-F8> <Esc>:cp<CR>

" size of preview window, eg git status
set previewheight=25
map <C-g> <Esc>:Gstatus<CR>
"map <C-G> :Dispatch! git stash ; git pull --rebase ; git push ; git stash pop<CR>

map <S-F5> :GitGutterToggle<cr>:set invnumber<cr>:set invrelativenumber<cr>

cmap w!! w !sudo tee % >/dev/null

" yank into the system buffer
"map Y :'<,'>w !xclip -i -sel c<CR><CR>
nnoremap Y y$

" permanent undo history of files
let s:undoDir = "/home/alla/.vim/undo"
let &undodir=s:undoDir
set undofile

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=8
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Make warning messages bright red
highlight WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

" list char
highlight SpecialKey ctermfg=236
highlight Comment ctermfg=247
highlight LineNr ctermfg=236

"set number
"set relativenumber
set cursorline
highlight cursorline cterm=none ctermbg=232
highlight cursorlinenr ctermfg=130

" better lines to delineate windows
hi VertSplit   ctermbg=NONE cterm=NONE
hi StatusLine   ctermbg=NONE cterm=NONE
hi StatusLineNC ctermbg=NONE cterm=NONE
set fillchars=stl:—,stlnc:—,vert:│

" fold markers
hi Folded ctermbg=NONE ctermfg=202

" current window gets cursorline, all others do not
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" compile and install go programs on save
 autocmd BufWritePost *.go :normal zo
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0

set hlsearch
highlight Search ctermbg=6
nnoremap <CR> :noh<CR><CR>

au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript

map <S-Up> <C-y>
map <S-Down> <C-e>
inoremap <S-Up> <C-x><C-y>
inoremap <S-Down> <C-x><C-e>

map <C-n> :cn<CR>
map <C-p> :cp<CR>

if &diff
    colorscheme apprentice
endif

" auto format a bash file on save
" mz = make a mark, gg=G = format whole file, `z = move to first mark
"filetype plugin indent on
"autocmd BufWritePre *.sh normal mzgg=G`z
set foldmethod=syntax
