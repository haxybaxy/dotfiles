return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "bold",
					},
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_bold = true
			vim.g.gruvbox_material_enable_italic = true
		end,
	},
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.everforest_background = "medium"
			vim.g.everforest_enable_italic = true
		end,
	},
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanso").setup({
				bold = true,
				italics = true,
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { bold = true },
				statementStyle = {},
				typeStyle = { bold = true },
			})
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd.colorscheme("tokyonight-storm")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd.colorscheme("dawnfox")
			end,
			update_interval = 3000,
			fallback = "dark",
		},
	},
}
