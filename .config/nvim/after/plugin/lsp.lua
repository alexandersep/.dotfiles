local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'lua_ls',
  'hls',
  'pyright',
  'clangd',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.set_preferences({
	sign_icons = {}
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

---
-- Setup haskell LSP
---
local haskell_tools = require('haskell-tools')
local hls_lsp = require('lsp-zero').build_options('hls', {})

local hls_config = {
  hls = {
    capabilities = hls_lsp.capabilities,
    on_attach = function(client, bufnr)
      local opts = {buffer = bufnr}

      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<leader>ca', vim.lsp.codelens.run, opts)
      vim.keymap.set('n', '<leader>hs', haskell_tools.hoogle.hoogle_signature, opts)
      vim.keymap.set('n', '<leader>ea', haskell_tools.lsp.buf_eval_all, opts)
    end
  }
}

-- Autocmd that will actually be in charging of starting hls
local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', {clear = true})
vim.api.nvim_create_autocmd('FileType', {
  group = hls_augroup,
  pattern = {'haskell'},
  callback = function()
    haskell_tools.start_or_attach(hls_config)

    ---
    -- Suggested keymaps that do not depend on haskell-language-server:
    ---

    -- Toggle a GHCi repl for the current package
    vim.keymap.set('n', '<leader>rr', haskell_tools.repl.toggle, opts)

    -- Toggle a GHCi repl for the current buffer
    vim.keymap.set('n', '<leader>rf', function()
      haskell_tools.repl.toggle(vim.api.nvim_buf_get_name(0))
    end, def_opts)

    vim.keymap.set('n', '<leader>rq', haskell_tools.repl.quit, opts)
  end
})
---
-- End of haskell setup
---

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
