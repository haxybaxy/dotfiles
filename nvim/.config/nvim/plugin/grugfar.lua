vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

require("grug-far").setup({})

-- Search & replace keymaps. Grouped under <leader>R ("replace") in which-key;
-- the group label is registered in plugin/vfx.lua.
vim.keymap.set("n", "<leader>Rr", function()
	require("grug-far").open()
end, { desc = "Search & replace (project)" })

vim.keymap.set("n", "<leader>Rw", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Replace word under cursor" })

vim.keymap.set("n", "<leader>Rf", function()
	require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Replace in current file" })

vim.keymap.set("x", "<leader>R", function()
	require("grug-far").with_visual_selection()
end, { desc = "Replace visual selection" })
