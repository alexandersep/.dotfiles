return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
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
                    "zig-out/",
                    ".zig-cache/",
                },
            },
        }
    end
}
