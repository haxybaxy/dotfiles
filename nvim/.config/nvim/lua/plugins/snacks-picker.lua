local layouts = require("plugins.snacks-picker.layouts").layouts
local sources = require("plugins.snacks-picker.sources").sources

return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			exclude = {
				".DS_Store",
				".git",
				"node_modules",
				"ios",
				"android",
				"dist",
        ".next",
        "venv",
        ".expo"
			},
			ui_select = true,
			hidden = true,
			ignored = true,

			layouts = layouts,

			win = {
				preview = {
					wo = {
						number = true,
					},
				},
				input = {
					keys = {
						["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
						["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
					},
				},
				list = {
					keys = {
						["<c-t>"] = "edit_tab",
					},
				},
			},

			sources = sources,
		},
	},
}
