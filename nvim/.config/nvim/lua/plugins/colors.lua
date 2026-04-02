return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				float = {
					transparent = false,
					solid = true,
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({})
		end,
	},
}
