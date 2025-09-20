return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    colors = {
        error = "#BBDCE5",
        hint = "#e1fe86",
        info = "#f6bb83",
        warning = "#A3DC9A",
        default = "#FFFFFF",
    },
    keywords = {
        FIX = {
            icon = "F", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = "T", color = "info" },
        HACK = { icon = "H", color = "warning" },
        WARN = { icon = "W", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "P", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "N", color = "hint", alt = { "INFO" } },
        TEST = { icon = "Te", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
        keyword = "fg",
        before = "",
        after = "",
        pattern = [[.*<(KEYWORDS)]],
        gui = "underline",
    },
    search = {
        pattern = [[\b(KEYWORDS)]],
    }
  }
}
