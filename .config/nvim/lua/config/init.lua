require('config.remap')
require('config.set')

-- ColourScheme for Neovim
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- remove 'o' every time a buffer is set up
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { "o" }
  end,
})
