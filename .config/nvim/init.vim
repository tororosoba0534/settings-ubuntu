source ~/.local/share/nvim/site/autoload/plug.vim
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
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
Plug 'yutkat/confirm-quit.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
call plug#end()

filetype plugin indent on
syntax enable
set termguicolors
set scrolloff=5
let g:python3_host_prog = system('echo -n $(which python3)')
let g:vimtex_view_method = 'zathura'

" This code should go in your vimrc or init.vim
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops
let g:UltiSnipsSnippetDirectoried=[$HOME.'/.config/nvim/UltiSnips']


map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1






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

lua << EOF
-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
require("bufferline").setup{}
require("scrollbar").setup{}
require("hlslens").setup()
local kopts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
require('Comment').setup()
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


