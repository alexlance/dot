set nocompatible        " must be the first line

set viminfo+=n~/.vim/viminfo
filetype on
filetype plugin on

hi clear
syntax reset
syntax on
set mouse=
set encoding=utf-8
set hlsearch
set expandtab
set softtabstop=2
set tabstop=2
set foldmethod=marker
set ruler
set bs=2
set sw=2
set background=dark
set backspace=indent,eol,start
set laststatus=2   " always display status line
set statusline+=%F " add full path of file to status line
set t_ti= t_te=    " don't clear screen after exit
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
"set showtabline=2
"set tabpagemax=500
"set tabline=
set copyindent
set backup
set backupdir=~/.vim/tmp/
set dir=~/.vim/tmp/

silent! colorscheme hybrid_material
set virtualedit=block

let mapleader=","

" quit/exit shortcuts fat fingers
cmap Q<CR> q<CR>
cmap Q!<CR> q!<CR>
cmap Q1<CR> q!<CR>
"cmap q1<CR> q!<CR>
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
nnoremap J gJ


" omni autocompletions per-language
autocmd FileType go setlocal sts=2 ts=2 sw=2 tabstop=2 noexpandtab nospell
autocmd FileType php setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell
autocmd FileType python setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell

" Disable the loading of hilighted matching parenthesis
let loaded_matchparen = 1

" put cursor back where it was last time when re-opening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" nuke all trailing space before a write
au BufWritePre * :%s/\s\+$//e

" for long lines
noremap j gj
noremap k gk

"  make <Backspace> act as <Delete> in Visual mode?
vmap <BS> x
"This changes the behavior of the . command to leave the cursor at the point where it was before editing started
nmap . .`[
nnoremap ; :

nmap gb i!gb!<esc>gqip?!gb!<cr>df!

if (v:version >= 700)
highlight SpellBad      ctermfg=Red         ctermbg=none
highlight SpellCap      ctermfg=Magenta     ctermbg=none
highlight SpellLocal    ctermfg=Magenta     ctermbg=none
highlight SpellRare     ctermfg=Magenta     ctermbg=none
endif

let g:buftabline_indicators = 1
nnoremap <C-t> :enew<CR>:n<space>
inoremap <C-t> <Esc>:enew<CR>:n<space>
nmap [1;2D :bprev<CR>
nmap [1;2C :bnext<CR>
imap [1;2D <Esc>:bprev<CR>
imap [1;2C <Esc>:bnext<CR>

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

nnoremap Y y$

" permanent undo history of files
let s:undoDir = "~/.vim/undo"
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

" switching tabs, leave cursor/buffer in same place
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" compile and install go programs on save
"autocmd BufWritePost *.go :normal zo
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_fmt_experimental = 1 " keep folds open when saving Go files

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



set formatlistpat=^\\s*                     " Optional leading whitespace
set formatlistpat+=[                        " Start character class
set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
set formatlistpat+=\\(                      " |  Start group
set formatlistpat+=[0-9]\\+                 " |  |  Numbers
set formatlistpat+=\\\|                     " |  |  or
set formatlistpat+=[a-zA-Z]\\+              " |  |  Letters
set formatlistpat+=\\)                      " |  End group
set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
set formatlistpat+=]                        " End character class
set formatlistpat+=\\s\\+                   " One or more spaces
set formatlistpat+=\\\|                     " or
set formatlistpat+=^\\s*[-–+o*•]\\s\\+      " Bullet points


