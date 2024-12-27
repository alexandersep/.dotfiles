return {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate',  -- Ensures parsers are installed and updated
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = {},
			auto_install = true,
			highlight = { enable = true },
		}
	end
}
