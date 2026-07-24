-- bootstrap lazy,nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to clone lazy.nvim: " .. vim.v.shell_error)
  end
end
vim.opt.rtp:prepend(lazypath)

-- general options
vim.o.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.g.mapleader = ' '  -- 'vim.g' sets global variables
vim.cmd[[colorscheme koehler]]
vim.opt.termguicolors = true

-- tab complete options
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"

-- vim.opt.clipboard = "unnamedplus"

-- Use OSC 52 for clipboard sync
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     -- ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     -- ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }

-- keymaps
local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})

options = { noremap = true }
-- map('n', '<leader>a', ':%!box -a coder<cr>', options)
map('n', '<leader>e', ':Ex<cr>', options)

map('n', '<leader>b', ':FzfLua buffers<cr>', options)
map('n', '<leader>f', ':FzfLua files<cr>', options)
map('n', '<leader>g', ':FzfLua grep<cr>', options)
map('n', '<leader>d', ':vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis<CR>', options)
map('n', '<leader>o', ':terminal opencode<CR>:file opencode<CR>', options)
map('n', '<leader>t', '<C-W>s<C-W>j:terminal<CR>', options)

-- don't clash with dtach
map('t', '<C-Space>', [[<C-\><C-n>]], { noremap = true })
-- turn off macro recording
vim.keymap.set('n', 'q', '<Nop>')

-- Plugins
require("lazy").setup({
	{
	  "ibhagwan/fzf-lua",
	},
})
