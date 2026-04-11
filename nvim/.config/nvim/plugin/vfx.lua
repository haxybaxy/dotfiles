vim.pack.add({
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/rcarriga/nvim-notify",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/mcauley-penney/visual-whitespace.nvim",
})

require("neoscroll").setup()

require("noice").setup({
	cmdline = {
		format = {
			search_down = {
				view = "cmdline",
			},
			search_up = {
				view = "cmdline",
			},
		},
	},
	views = {
		cmdline_popup = {
			position = "90%",
			border = {
				style = "none",
				padding = { 2, 3 },
			},
			filter_options = {},
			win_options = {
				winhighlight = "NormalFloat:Pmenu,FloatBorder:Pmenu",
			},
		},
	},
})

local wk = require("which-key")
wk.setup({
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
	},
})
wk.add({
	{ "<leader>gt", group = "tabs" },
	{ "<leader>gtn", desc = "New Tab" },
	{ "<leader>gtx", desc = "Close Tab" },
	{ "<leader>t", group = "test" },
	{ "<leader>d", group = "debug" },
	{ "<leader>1", desc = "Tab 1", hidden = true },
	{ "<leader>2", desc = "Tab 2", hidden = true },
	{ "<leader>3", desc = "Tab 3", hidden = true },
	{ "<leader>4", desc = "Tab 4", hidden = true },
	{ "<leader>5", desc = "Tab 5", hidden = true },
	{ "<leader>6", desc = "Tab 6", hidden = true },
	{ "<leader>7", desc = "Tab 7", hidden = true },
	{ "<leader>8", desc = "Tab 8", hidden = true },
	{ "<leader>9", desc = "Tab 9", hidden = true },
	{ "<leader>0", desc = "Last Tab", hidden = true },
})

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

require("todo-comments").setup()

require("nvim-highlight-colors").setup({
	render = "background",
})

require("visual-whitespace").setup({})
