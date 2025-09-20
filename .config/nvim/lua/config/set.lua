vim.opt.guicursor = ""

vim.opt.cinoptions="l1"
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.foldenable = false
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

local build_term_buf = nil

local function run_build_bat()
	-- Save current window
	local cur_win = vim.api.nvim_get_current_win()

	-- Get current file directory
	local cwd = vim.fn.expand('%:p:h')

	-- Walk up the directory tree to find build.bat
	local function find_build(dir)
		local build_path = dir .. '/build.bat'
		if vim.fn.filereadable(build_path) == 1 then
			return build_path
		end
		local parent = vim.fn.fnamemodify(dir, ':h')
		if parent == dir then
			return nil -- reached root
		end
		return find_build(parent)
	end

	local build_file = find_build(cwd)
	if not build_file then
		print("No build.bat found in parent directories.")
		return
	end

	-- Kill old terminal buffer if still around
	if build_term_buf and vim.api.nvim_buf_is_valid(build_term_buf) then
		vim.api.nvim_buf_delete(build_term_buf, { force = true })
		build_term_buf = nil
	end

	-- Open a fresh vertical terminal running build.bat
	vim.cmd('vert rightbelow split | terminal "' .. build_file .. '"')
	build_term_buf = vim.api.nvim_get_current_buf()

	-- Give it a nice name (shows in buffer list & statusline)
	vim.api.nvim_buf_set_name(build_term_buf, "build://terminal")

	-- Map <Esc> in this buffer to close it
	vim.keymap.set('n', '<Esc>', '<C-\\><C-n>:bd!<CR>', { buffer = build_term_buf, nowait = true })

	-- Restore cursor to original buffer
	if vim.api.nvim_win_is_valid(cur_win) then
		vim.api.nvim_set_current_win(cur_win)
	end
end

-- Create a command for convenience
vim.keymap.set('n', '<leader>b', run_build_bat, { noremap = true, silent = true, desc = "Run build.bat" })

-- todo-comments.lua
vim.keymap.set('n', '<leader>to', function()
      vim.cmd.TodoTelescope()
end)

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

vim.keymap.set('n', '<leader>cp', absolute_path, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cf', filename, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cp', relative_path, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>tb', function()
  require('telescope.builtin').buffers({
    sort_mru = true,
    ignore_current_buffer = true
  })
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader><Esc>', '<C-w>w', { noremap = true, silent = true, desc = "Switch window" })

-- Never insert comments after 'o'
vim.opt.formatoptions:remove { "o" }

-- storage for last command
local last_cmd = nil
-- safe runner with wrap-around
local function run_cmd(cmd)
  last_cmd = cmd
  local ok, _ = pcall(vim.cmd, cmd)
  if not ok then
    if cmd == "cnext" then
      vim.cmd("cfirst") -- wrap to first error
    elseif cmd == "cprev" then
      vim.cmd("clast")  -- wrap to last error
    end
  end
end

-- mappings for next/prev error that also update last_cmd
vim.keymap.set('n', '<leader>ne', function() run_cmd("cnext") end)
vim.keymap.set('n', '<leader>pe', function() run_cmd("cprev") end)

-- <leader><leader> repeats last stored command
vim.keymap.set('n', '<leader><leader>', function()
  if last_cmd then
    run_cmd(last_cmd) -- re-run with wrapping
  else
    print("No command recorded yet")
  end
end)
