local picker_config = require("plugins.snacks.picker-config")
local dashboard_config = require("plugins.snacks.dashboard-config")

return {
	---@module "snacks"
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = { enabled = true },
		bigfile = { enabled = true },
		quickfle = { enabled = true },
		explorer = { enabled = true },
		input = { enabled = true },
		image = { enabled = true, doc = { inline = false } },
		statuscolumn = { enabled = true },
    zen = {
      enabled = true,
      toggles = { dim = false},
    },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = picker_config.picker,
		dashboard = dashboard_config.dashboard,
    styles = {
      zen = {
        backdrop = { transparent = false, blend = 99 },
      }
    }
	},
	keys = {
		{ "<leader><space>", function() Snacks.picker.grep() end, desc = "Ripgrep", },
		{ "<leader>f", function() Snacks.picker.files() end, desc = "Find Files", },
		{ "<leader>r", function() Snacks.picker.recent() end, desc = "Recent", },
		-- { "<leader>j", function() Snacks.picker.highlights({pattern = "hl_group:^Snacks"}) end, desc = "Recent", },
    { "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP Definitions", },
    { "<leader>gr", function() Snacks.picker.lsp_references() end, desc = "LSP References", },
		{ "<leader>bf", function() Snacks.picker.buffers() end, desc = "Buffers", },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer", },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
		{ "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History", },
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
	},
}
