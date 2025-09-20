return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    vim.lsp.config(server_name, {
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            local opts = { buffer = bufnr, remap = false }
                            -- Set up common LSP keymaps
                            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                            vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
                            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
                            vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
                            vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
                            vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
                        end,
                    }) 
                    vim.lsp.enable(server_name)
                end,
            }
        })
        vim.lsp.config("mlir-lsp-server", {
            name = "mlir-lsp-server",
            cmd = {"mlir-lsp-server"},
            filetypes = {"mlir"},
        })
        vim.lsp.enable('mlir-lsp-server')

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
