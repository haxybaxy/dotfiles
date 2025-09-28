return {
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		config = function()
			if vim.o.background == "dark" then
				vim.cmd("colorscheme vscode")
			end
		end,
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
			if vim.o.background == "light" then
				vim.cmd("colorscheme catppuccin")
			end
		end,
	},
}
