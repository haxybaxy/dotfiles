vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	animate = { enabled = true },
	bigfile = { enabled = true },
	quickfle = { enabled = true },
	image = { enabled = true, doc = { inline = false } },
	statuscolumn = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	lazygit = {
		theme = { ---@diagnostic disable-line: missing-fields
			searchingActiveBorderColor = { fg = "Visual", bold = true },
			selectedLineBgColor = { bg = "Visual" },
			inactiveBorderColor = { fg = "SnacksPickerUnselected" },
		},
		win = {
			wo = {
				winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal",
			},
		},
	},
})

vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

vim.keymap.set("n", "<leader>bn", function()
	Snacks.notifier.show_history()
end, { desc = "Notification History" })

Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle
	.new({
		id = "git_signs",
		name = " Git Sign Column",
		get = function()
			return require("gitsigns.config").config.signcolumn
		end,
		set = function(state)
			require("gitsigns").toggle_signs(state)
		end,
	})
	:map("<leader>ug")
