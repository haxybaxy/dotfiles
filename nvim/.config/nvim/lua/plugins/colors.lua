return {
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 999,
		config = function()
			require("catppuccin").setup({
				float = {
					transparent = false,
					solid = false,
				},
			})
		end,
	},
}
