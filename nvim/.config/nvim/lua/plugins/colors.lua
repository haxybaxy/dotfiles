return {
	{ -- dark mode
		"Mofiqul/vscode.nvim",
		priority = 1000,
	},
	{ -- light mode
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
