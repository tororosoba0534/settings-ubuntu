source ~/.local/share/nvim/site/autoload/plug.vim
call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*'}
call plug#end()

filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'




let g:vimwiki_autowriteall = 1
set cmdheight=3 
set clipboard&
set clipboard=unnamedplus

"
" vim-fugitive configuration
function GitStatusWithSmallVerticalWindow()
	let parent_win_width = 70
	below vertical Git
	vertical resize 70
endfunction
function! ToggleGStatus()
	if buflisted(bufname('fugitive:///*/.git/'))
		execute ":bdelete" bufname('fugitive:///*/.git/')
	else
		call GitStatusWithSmallVerticalWindow()
	endif
endfunction
nnoremap <A-g> :call ToggleGStatus()<CR>

"
" undotree configurations
let g:undotree_SetFocusWhenToggle = 1
nnoremap <A-u> :UndotreeToggle<CR>

"
" bufferline.nvim config
lua << EOF
require("bufferline").setup{}
EOF

command! Sv :source $MYVIMRC
command! St :!tmux source-file ~/settings-ubuntu/.tmux.conf
command! Sb :!source ~/.bashrc

cnoremap man vertical Man<SPACE>

nnoremap <A-/> :below vsplit .<CR>
nnoremap <A--> :below split .<CR>
nnoremap <A-t> :tabnew .<CR>
nnoremap <A-j> :wincmd w<CR>
nnoremap <A-k> :wincmd W<CR>
nnoremap <A-h> :bprev<CR>
nnoremap <A-l> :bnext<CR>

" Enable multi-cursor behaviour in visual mode with <C-c>.
" If you want to interrupt vim sequence and invalidate crashed vim script, use
" <ESC>.
inoremap <C-c> <ESC>---
inoremap <ESC> <C-c>---


