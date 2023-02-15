vim.go.loaded_netrw = 1
vim.go.loaded_netrwPlugin = 1

vim.cmd('source ~/.config/nvim/vim/plugins.vim')

-- auto IME off
-- fcitx5-remote breaks xmodmap configuration, so please considering replacing
-- it with xkb options.
require(fcitx5)

vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')
vim.o.completeopt = {'menu', 'menuone', 'noselect'}
vim.o.termguicolors
vim.o.pumblend = 10
vim.o.scrolloff = 5
vim.o.wrap
vim.o.showbreak = '>>>'
vim.o.breakindent
vim.cmd("let g:python3_host_prog = system('echo -n $(which python3)')")

vim.o.statusline = '%F\%=%l/%L\ lines\ (%p%%)'

vim.cmd([[
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
]])

vim.api.nvim_set_keymap('n', '<A-s>', ':Files ~/settings-ubuntu<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-n>', ':Files ~/Dropbox/notetaking/<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-a>', ':Files ~/Dropbox/articles/<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-b>', 'Buffers<CR>', {noremap = true})

-- vim.api.nvim_create_augroup('fzf', {})
-- vim.api.nvim_create_autocmd({"FileType"}, {group})
vim.api.nvim_set_keymap('n', '<A-e>s', ':NvimTreeToggle ~/settings-ubuntu/<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-e>c', ':NvimTreeToggle ~/settings-ubuntu/.config/<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-e>d', ':NvimTreeToggle ~/Dropbox<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-e>n', ':NvimTreeToggle ~/Dropbox/notetaking<CR>', {noremap = true})


require('lsp')

require("bufferline").setup{}
