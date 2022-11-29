vim.cmd('source ~/.local/share/nvim/site/autoload/plug.vim')
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim')

Plug 'vimwiki/vimwiki'
-- Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

vim.call('plug#end')


vim.cmd('let g:vimwiki_autowriteall = 1')
vim.o.cmdheight = 3
