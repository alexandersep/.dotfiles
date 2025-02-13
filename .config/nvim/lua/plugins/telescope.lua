return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fr', builtin.resume, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>rf', builtin.lsp_references, {})
        -- Set up Telescope options including file ignore patterns
        require('telescope').setup{
            defaults = {
                -- Add patterns of files and directories to ignore
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "%.log",
                    "%.tmp",
                    "build/",
                    "bin/",
                    "zig-out/",
                    ".zig-cache/",
                    -- Binaries
                    "%.exe",
                    "%.bin",
                    "%.out",
                    -- Latex specific
                    "%.toc",
                    "%.lot",
                    "%.lof",
                    "%.out",
                    "%.aux",
                    "%.pdf",
                    -- Images
                    "%.png",
                    "%.jpg",
                },
            },
        }
    end
}
