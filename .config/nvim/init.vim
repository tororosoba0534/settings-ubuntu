source ~/.local/share/nvim/site/autoload/plug.vim
call plug#begin()
" Language supports
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-omni'

" Others
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*'}
Plug 'tpope/vim-repeat'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tami5/sqlite.lua'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'petertriho/nvim-scrollbar'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'haya14busa/vim-asterisk'
" Plug 'yutkat/confirm-quit.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
call plug#end()

filetype plugin indent on
syntax enable
set completeopt=menu,menuone,noselect
set termguicolors
set pumblend=10
set scrolloff=5
let g:python3_host_prog = system('echo -n $(which python3)')
let g:vimtex_view_method = 'zathura'



" map *   <Plug>(asterisk-*)
" map #   <Plug>(asterisk-#)
" map g*  <Plug>(asterisk-g*)
" map g#  <Plug>(asterisk-g#)
" map z*  <Plug>(asterisk-z*)
" map gz* <Plug>(asterisk-gz*)
" map z#  <Plug>(asterisk-z#)
" map gz# <Plug>(asterisk-gz#)
" let g:asterisk#keeppos = 1






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

runtime init/lsp.vim

lua << EOF
require("bufferline").setup{}
require("scrollbar").setup{}
require("hlslens").setup()
EOF

command! Sv :source $MYVIMRC
command! St :!tmux source-file ~/settings-ubuntu/.tmux.conf
command! Sb :!source ~/.bashrc
command! Ss :call UltiSnips#RefreshSnippets()

" cnoremap man vertical Man<SPACE>
command! Ma :vertical Man

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


