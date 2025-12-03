-- bootstrap lazy,nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- general options
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.o.laststatus = 0
vim.g.mapleader = ' '  -- 'vim.g' sets global variables
vim.cmd[[colorscheme koehler]]

-- keymaps
local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})

options = { noremap = true }
vim.keymap.set('i', 'jk', '<Esc>')
-- map('n', '<leader><space>', '<C-W><C-W>', options)
-- map('n', '<leader>e', ':Ex<cr>', options)
-- map('n', '<leader>b', ':FzfLua buffers<cr>', options)
-- map('n', '<leader>f', ':FzfLua files<cr>', options)
-- map('n', '<leader>g', ':FzfLua grep<cr>', options)
-- map('n', '<leader>r', ':FzfLua command_history<cr>', options)

vim.keymap.set('n', '<space>y', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end)

vim.keymap.set("n", "<space>c", function()
  vim.ui.input({}, function(c) 
      if c and c~="" then 
        vim.cmd("noswapfile vnew") 
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
      end 
  end) 
end)

-- Plugins
require("lazy").setup({
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- },
	-- {
	--   "ibhagwan/fzf-lua",
	-- },
	-- {
	--   "hrsh7th/nvim-cmp",
	--   event = "InsertEnter",
	--   dependencies = {
	-- 	"neovim/nvim-lspconfig",
	-- 	"hrsh7th/cmp-nvim-lsp",
	-- 	"hrsh7th/cmp-buffer",
	-- 	"hrsh7th/cmp-path",
	-- 	"hrsh7th/cmp-cmdline",
	--   },
	-- },
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	"neovim/nvim-lspconfig",
	-- },
	-- {
	-- 	"terrortylor/nvim-comment"
	-- },
})

-- require("mason").setup()
-- require("mason-lspconfig").setup()

-- local cmp = require'cmp'
--
-- cmp.setup({
--     snippet = {
--       expand = function(args)
--         vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--       end,
--     },
--   mapping = {
--     ['<Tab>'] = cmp.mapping.select_next_item(),
-- 	['<S-Tab>'] = cmp.mapping.select_prev_item(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require('lspconfig').pylsp.setup({capabilities = capabilities,
-- 				 settings = { pylsp = { plugins = { pycodestyle={enabled=false},
-- 			 										pylint={enabled=false},
-- 													pyflakes={enabled=false}
-- 												  } } }
-- 			         })
-- require('lspconfig').ts_ls.setup{capabilities = capabilities}
-- require('lspconfig').bashls.setup{capabilities = capabilities}
--
-- require('nvim_comment').setup()

