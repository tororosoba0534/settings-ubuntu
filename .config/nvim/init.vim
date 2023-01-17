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
" Plug 'vimwiki/vimwiki'
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

set statusline=%F\%=%l/%L\ lines\ (%p%%)


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
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
	\,sm:block-blinkwait175-blinkoff150-blinkon175

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
nnoremap <A-b> :Buffers<CR>
nnoremap <A-e>S :Files ~/settings-ubuntu<CR>
nnoremap <A-e>C :Files ~/settings-ubuntu/.config/<CR>
nnoremap <A-e>D :Files ~/Dropbox/<CR>
nnoremap <A-e>N :Files ~/Dropbox/notetaking/<CR>
nnoremap <A-e>A :Files ~/Dropbox/articles/<CR>
nnoremap <A-e>R :Files ~/Dropbox/articles/reports/<CR>
nnoremap <A-e>P :Files ~/Documents/practice/<CR>
let g:fzf_action = {'/': 'below vsplit', '-': 'below split'}
augroup fzf
	autocmd!
	" autocmd FileType fzf tnoremap <buffer> <A-e> <c-c>:NvimTreeToggle<CR>
	autocmd FileType fzf tnoremap <buffer> <A-b> <c-c>
	" autocmd FileType fzf echo "Hey!"
augroup END
nnoremap <A-e>e :NvimTreeToggle<CR>
nnoremap <A-e>s :NvimTreeClose \| NvimTreeOpen ~/settings-ubuntu/<CR>
nnoremap <A-e>c :NvimTreeClose \| NvimTreeOpen ~/settings-ubuntu/.config/<CR>
nnoremap <A-e>d :NvimTreeClose \| NvimTreeOpen ~/Dropbox/<CR>
nnoremap <A-e>n :NvimTreeClose \| NvimTreeOpen ~/Dropbox/notetaking/<CR>
nnoremap <A-e>a :NvimTreeClose \| NvimTreeOpen ~/Dropbox/articles/<CR>
nnoremap <A-e>r :NvimTreeClose \| NvimTreeOpen ~/Dropbox/articles/reports/<CR>
nnoremap <A-e>p :NvimTreeClose \| NvimTreeOpen ~/Documents/practice/<CR>
augroup NvimTree
	autocmd!
	" autocmd FileType NvimTree nnoremap <buffer> <c-c> :close<CR>
	" autocmd BufEnter NvimTree echo "Hey!"<CR>
augroup END

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
function! EditInOtherDir(dirPath, ...)
	execute 'cd'  fnameescape(a:dirPath)
	try
		" let fileNames = a:000[1:]
		let fileNames = a:000
		" execute 'e' a:fileNames
		for name in fileNames
			execute 'e' name
		endfor
	finally
		cd -
	endtry
endfunction
command! -nargs=* En :call EditInOtherDir('~/Dropbox/notetaking/', <f-args>)  "cd ~/Dropbox/notetaking/<CR>:e <args><CR>:cd -

" cnoremap man vertical Man<SPACE>
" command! Ma -nargs=1 :vertical Man <args>
nnoremap <A-m> :bel vert Man<SPACE>

nnoremap <C-w>/ :below vsplit<CR>
nnoremap <C-w>- :below split<CR>
nnoremap <C-w>c :close<CR>
nnoremap <C-w>D :bn \| bd#<CR>
nnoremap <C-w>j :wincmd w<CR>
nnoremap <C-w>k :wincmd W<CR>
nnoremap <C-w>h :bprev<CR>
nnoremap <C-w>l :bnext<CR>
nnoremap <C-w>w :vert res +25<CR> 
nnoremap <C-w>W :vert res -25<CR> 
nnoremap <C-w>t :res +15<CR>
nnoremap <C-w>T :res -15<CR>
nnoremap <C-w>= :horizontal wincmd =<CR>

set equalalways
set winfixheight

" DO NOT get rid of <C-C> as process-killer.
noremap <C-g> <ESC>
noremap! <C-g> <ESC>
tnoremap <C-g> <C-\><C-n>

inoremap <Tab> <ESC>>>A
inoremap <S-Tab> <ESC><<A
noremap <Tab> >>
noremap <S-Tab> <<

function! OpenTerminal()
	bel sp
	te
	res 15
endfunction
command T call OpenTerminal()
" tnoremap <C-[> <C-\><C-n>
tnoremap <C-w>j <C-\><C-n>:wincmd w<CR>
tnoremap <C-w>k <C-\><C-n>:wincmd W<CR>
augroup terminal
	autocmd!
	autocmd FocusLost * hi TermCursor cterm=NONE gui=NONE
	autocmd FocusGained * hi TermCursor cterm=reverse gui=reverse
augroup END

lua << EOF
require("nvim-tree").setup()
-- vim.api.nvim_set_keymap('n', '<A-f>', ':NvimTreeToggle<CR>', {noremap = true})
EOF
