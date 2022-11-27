vim.cmd('source ~/.local/share/nvim/site/autoload/plug.vim')
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim')

Plug 'vimwiki/vimwiki'

vim.call('plug#end')


vim.cmd('let g:vimwiki_autowriteall = 1')
