let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
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
Plug 'folke/trouble.nvim'

" Others
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*'}
" Plug 'tpope/vim-repeat'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tami5/sqlite.lua'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
" Plug 'petertriho/nvim-scrollbar'
" Plug 'kevinhwang91/nvim-hlslens'
" Plug 'haya14busa/vim-asterisk'
" Plug 'yutkat/confirm-quit.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'numToStr/Comment.nvim'
call plug#end()


" auto IME off
" fcitx5-remote breaks xmodmap configuration, so please considering replacing
" it with xkb options.
luafile ~/settings-ubuntu/.config/nvim/init/fcitx5.lua
" source ~/settings-ubuntu/.config/nvim/init/fcitx5.vim


	

filetype plugin indent on
syntax enable
set completeopt=menu,menuone,noselect
set termguicolors
set pumblend=10
set scrolloff=5
set wrap
set showbreak=>>>
set breakindent
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
" set cmdheight=3 
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
" fzf.vim configurations
" nnoremap <A-f> :Files<CR>
nnoremap <A-s> :Files ~/settings-ubuntu<CR>
" nnoremap <A-d> :Files ~/Dropbox/<CR>
nnoremap <A-n> :Files ~/Dropbox/notetaking/<CR>
nnoremap <A-a> :Files ~/Dropbox/articles/<CR>
nnoremap <A-b> :Buffers<CR>
let g:fzf_action = {'/': 'below vsplit', '-': 'below split'}

runtime init/lsp.vim

lua require("bufferline").setup{}
" lua require("scrollbar").setup{}
" lua require("hlslens").setup()

function! Tex()
	if (&ft != 'tex')
		echo 'NO TEX!'
		return 1
	endif
	!latexmk -cd %:h/ %
	" echo "YES!!"
endfunction

command! Sv :source $MYVIMRC
command! St :!tmux source-file ~/settings-ubuntu/.tmux.conf
command! Sb :!source ~/.bashrc
command! Ss :call UltiSnips#RefreshSnippets()
command! Sx :!xmodmap ~/.Xmodmap; xmonad --recompile && xmonad --restart && killall xmobar && xmobar
command! Tex :call Tex()
command! Zathura :!zathura %:p:r.pdf &

" cnoremap man vertical Man<SPACE>
" command! Ma -nargs=1 :vertical Man <args>

" nnoremap <A-/> :below vsplit .<CR>
" nnoremap <A--> :below split .<CR>
" nnoremap <A-t> :tabnew .<CR>
nnoremap <A-j> :wincmd w<CR>
nnoremap <A-k> :wincmd W<CR>
nnoremap <A-h> :bprev<CR>
nnoremap <A-l> :bnext<CR>

" If vimscript craches, you should kill vim process.
inoremap <C-C> <ESC>

lua << EOF
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<A-f>', ':NvimTreeToggle<CR>', {noremap = true})
EOF
