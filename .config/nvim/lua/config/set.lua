vim.opt.guicursor = ""

vim.opt.cinoptions="l1"
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
vim.api.nvim_set_keymap('i', '<C-v>', '"+p', { noremap = true })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

vim.keymap.set('n', '<leader>lp', vim.cmd.LspStop)
vim.keymap.set('n', '<leader>lt', vim.cmd.LspStart)

local function relative_path()
    filepath = vim.fn.expand('%')
    vim.fn.setreg("+", filepath)
end

local function absolute_path()
    local filepath = vim.fn.expand('%:p')
    vim.fn.setreg("+", filepath)
end

local function filename()
    local filepath = vim.fn.expand('%:t')
    vim.fn.setreg("+", filepath)
end

vim.keymap.set('n', '<leader>cp', relative_path)
vim.keymap.set('n', '<leader>pc', absolute_path)
vim.keymap.set('n', '<leader>fp', filename)
