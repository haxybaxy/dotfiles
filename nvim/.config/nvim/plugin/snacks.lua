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
