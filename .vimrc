packadd! matchit
packadd! editorconfig
packadd! comment
packadd! osc52

set nowrap
set textwidth=80
set shiftwidth=4
set tabstop=8
set autoindent
set copyindent
set hlsearch
set mouse=a
set spr
"set clipmethod=osc52

set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=10

syntax on
colorscheme sunbather

let mapleader = " "

" easier than <C-w>
nnoremap <leader>w <C-w>

" Move between buffers
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>

" Move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" J is a curse upon humanity
nnoremap J <Nop>

" clear search on double esc
nnoremap <Esc> :nohlsearch<CR>

" netrw file tree
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
nnoremap <leader>e :Lexplore!<CR>

" cursorline when insert
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

"Kitty Integration
"let windows = json_decode(system('kitten @ ls'))
"if len(windows) == 1
"    let opacity = windows[0].background_opacity
"endif
"
"silent! call system('kitten @ set-font-size -- 14')
"silent! call system('kitten @ set-background-opacity 1')
"autocmd VimLeavePre * silent! call system('kitten @ set-font-size -- 0')
"autocmd VimLeavePre * silent! call system('kitten @ set-background-opacity' . opacity)

"silent !kitten @ --to="$KITTY_LISTEN_ON" --no-response set-font-size -- 14 >/dev/null 2>&1
"autocmd VimLeavePre * silent !kitten @ --to="$KITTY_LISTEN_ON" --no-response set-font-size -- 0 >/dev/null 2>&1
