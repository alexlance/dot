filetype on
filetype plugin on
syntax on
au BufRead,BufNewFile *.screenplay    set filetype=screenplay

autocmd BufWritePost */alloc/javascript/*.js :silent !(make cache > /dev/null)
autocmd BufWritePost */alloc/css/src/* :silent       !(make css > /dev/null)


set encoding=utf-8
set expandtab
set softtabstop=2
set tabstop=2
set foldmethod=marker
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

let makeprg = "php -l %"

"function MyTabOrComplete()
"    let col = col('.')-1
"    if !col || getline('.')[col-1] !~ '\k'
"         return "\<tab>"
"    else
"         return "\<C-N>"
"    endif
"endfunction

function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
inoremap <Tab> <C-R>=SuperTab()<CR>

" imap <Tab> <C-P>



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
"au FileType javascript set foldlevel=1
au FileType python set foldlevel=1
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP




set bs=2    " allow backspacing over everything in insert mode (for Vanilla!)
set sw=2
"set bg=light
set bg=dark
set laststatus=2
set highlight=sb
set ignorecase 
set smartcase
set grepprg=grep\ -rsin\ $*\ *
"set formatprg=par
set wildmode=longest,list,full
set wildmenu
set tabpagemax=500


" Nuke spaces till end of line
map -- :%s/\s*$//g<CR>:noh<CR>
 
"map q gq<Down>


"autocmd FileWritePre *.php call ValidatePHP()
set scrolloff=0
set confirm

set nojoinspaces      " Use only one space after '.' when joining lines, instead of two
set shiftround        " round to 'shiftwidth' for "<<" and ">>" 
"runtime macros/matchit.vim



" Disable the loading of the paren thing
let loaded_matchparen = 1


"More attempt at fixing backspace when nested screens decide to change me $TERM and render delete useles
" note that the following value is made by hitting ctrl-v and then backspace...
" this remaps backspace to actualy BACKSPACE - not delete.
set t_kb=

"This changes the behavior of the . command to leave the cursor at the point where it was before editing started.
nmap . .`[

" This adjusts the title of my screen sessions.
set titleold=bash
let &titlestring = expand("%:t") 

if &term == "screen" 
  set t_ts=k
  set t_fs=\
endif

if &term == "screen" || &term == "xterm" 
  set title 
endif

let php_folding=1

nmap gb i!gb!<esc>gqip?!gb!<cr>df!

set ff=unix


if has("spell")
  setlocal spell spelllang=en_au spellfile=/home/alla/.vim/spellfile.add
endif


if (v:version >= 700)
highlight SpellBad      ctermfg=Red         ctermbg=none
highlight SpellCap      ctermfg=Magenta     ctermbg=none
highlight SpellLocal    ctermfg=Magenta     ctermbg=none
highlight SpellRare     ctermfg=Magenta     ctermbg=none
endif


" Tab settings
map <C-t> :tabnew<CR>:e 
nmap <C-t> :tabnew<CR>:e 
imap <C-t> <Esc>:tabnew<CR>:e 

" shift-arrows
nmap [1;2D  :tabp<CR>
nmap [1;2C :tabn<CR>
imap [1;2D <Esc>:tabp<CR>
imap [1;2C <Esc>:tabn<CR>

imap <S-Left> <Esc>:tabp<CR>
imap <S-Right> <Esc>:tabn<CR>

map <S-Up> <C-y>
map <S-Down> <C-e>
map <F4> <Esc>:g/^./,/\n$/j<CR>

set showtabline=2

highlight TabLine       ctermfg=green ctermbg=None cterm=None
highlight TabLineFill   ctermfg=white ctermbg=None cterm=None
highlight TabLineSel    ctermfg=202

"highlight Folded  ctermfg=grey  ctermbg=black
highlight Folded ctermfg=8 guifg=#808080
highlight Comment ctermfg=8 guifg=#808080

function! ResCur()
if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Highlight trailing whitespace etc
"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+\%#\@<!$/
"
"set listchars=tab:>-,trail:-
"
" Go (golang) whitespace: real tabs.
autocmd FileType go setlocal sts=2 ts=2 sw=2 tabstop=2 noexpandtab nospell
autocmd FileType php setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell
autocmd FileType python setlocal sts=2 ts=2 sw=2 tabstop=2 expandtab nospell

" performance on large files
"set synmaxcol=100
set copyindent

"map <C-d> :r !date "+\%F \%T  \%a"<cr>A  
"imap <C-d> <esc>:r !date "+\%F \%T  \%a"<cr>A  

" turn on backup

set backup
" " Set where to store backups
set backupdir=/home/alla/.vim/tmp/
" " Set where to store swap files
set dir=/home/alla/.vim/tmp/
set viminfo+=n/home/alla/.vim/viminfo

" list char
hi SpecialKey ctermfg=236
hi Comment ctermfg=238
hi TabLineSel ctermfg=White 
hi TabLine ctermfg=245

au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript
