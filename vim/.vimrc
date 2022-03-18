set number
set fileencodings=utf-8,cp932
set cursorline
syntax enable
set hlsearch
set incsearch
set smartindent
set laststatus=2
set wildmenu

" <Leader>キーをスペースに割り当て
let g:mapleader = "\<Space>"

" スペース+wでファイル保存
nnoremap <Leader>w :w<CR>

" Esc2度押しでハイライト削除
nnoremap <Esc><Esc> :nohlsearch<CR>

