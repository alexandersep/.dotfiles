vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50 -- lsp is benefitted from fast response

vim.opt.scrolloff = 8 -- specifies the number of screen lines to keep above and below the cursor
vim.opt.signcolumn = "no" -- remove column on side
vim.opt.isfname:append("@-@")

-- Copy to clipboard and primary selection
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

vim.keymap.set('n', '<leader>lp', vim.cmd.LspStop)
vim.keymap.set('n', '<leader>lt', vim.cmd.LspStart)
