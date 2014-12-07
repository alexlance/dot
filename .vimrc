filetype on
filetype plugin on
syntax on
au BufRead,BufNewFile *.screenplay    set filetype=screenplay

autocmd BufWritePost /var/www/alloc/javascript/*.js :silent !(cd /var/www/alloc && make cache > /dev/null)
autocmd BufWritePost /var/www/alloc/css/src/* :silent !(cd /var/www/alloc && make css > /dev/null)

autocmd BufWritePost /var/www/alouy.raw-sugar.net/htdocs/javascript/*.js :silent !(cd /var/www/alouy.raw-sugar.net/htdocs/ && make cache > /dev/null)
autocmd BufWritePost /var/www/alouy.raw-sugar.net/htdocs/css/src/* :silent !(cd /var/www/alouy.raw-sugar.net/htdocs && make css > /dev/null)

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

let makeprg = "php -l %"

function MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
         return "\<tab>"
    else
         return "\<C-N>"
    endif
endfunction

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

" omni autocompletions per-language
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"au FileType javascript set foldlevel=1
au FileType python set foldlevel=1
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP




"map <F5> <Esc>ba_POST["<Esc>ea"]<Esc>
"map <F6> <Esc>ba_GET["<Esc>ea"]<Esc>

" map <F7> <Esc>:%s/<TABLE/<table/g<cr><Esc>:%s/<TR/<tr/g<cr>:%s/<TD/<td/g<cr>:%s/<TH/<th/g<cr>:%s/<CENTER/<center/g<cr>:%s/<FORM/<form/g<cr>:%s/<TEXTAREA/<textarea/g<cr>:%s/<INPUT/<input/g<cr>:%s/<SELECT/<select/g<cr>:noh<cr>
" map <F8> <Esc>:%s/<\/TABLE/<\/table/g<cr>:%s/<\/TR/<\/tr/g<cr>:%s/<\/TD/<\/td/g<cr>:%s/<\/TH/<\/th/g<cr>:%s/<\/CENTER/<\/center/g<cr>:%s/<\/FORM/<\/form/g<cr>:%s/<\/TEXTAREA/<\/textarea/g<cr>:%s/<\/INPUT/<\/input/g<cr>:%s/<\/SELECT/<\/select/g<cr>:noh<cr>

" Map F7 to making html lower case..
" using : instead of forward slashes to delimit search and replace. 
"map <F7> <Esc>:%s:<\(/\=\)\(B\\|U\\|H1\\|H2\\|H3\\|H4\\|H5\\|H6\\|HR\\|BR\\|FONT\\|TABLE\\|TR\\|TD\\|TH\\|CENTER\\|FORM\\|TEXTAREA\\|INPUT\\|SELECT\\|OPTION\\|SCRIPT\):<\L\1\2:g<CR>:noh<CR>

"imap ( ()<Esc>i
"imap [ []<Esc>i
"imap < <><Esc>i
"imap { {}<Esc>i
"imap BR echo "<br>"
"ab BR+ echo "<br>"
"ab br+ echo "<br>"
"ab $q+ $q = sprintf("");<CR>$db->query($q);<CR>while ($db->next_record()) {<CR><CR>}

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
 

"autocmd FileWritePre *.php call ValidatePHP()
"set scrolloff=10

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


" screenplay actions
"map <F1> i                <esc>:set tw=70<CR>i
" screenplay character names
"map <F2> i                                     
" screenplay dialog
"map <F3> i                          <esc>:set tw=60<CR>i
"map <F1> <esc>:set tw=68<CR>
"map <F2> <esc>:set tw=60<CR>


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

" turn on backup
set backup
" " Set where to store backups
set backupdir=/home/alla/.vim/tmp/
" " Set where to store swap files
set dir=/home/alla/.vim/tmp/
set list
set listchars=tab:..,trail:.

" list char
hi SpecialKey ctermfg=236
hi Comment ctermfg=238
hi TabLineSel ctermfg=White 
hi TabLine ctermfg=245

