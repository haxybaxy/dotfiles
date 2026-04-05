vim.pack.add({ "https://github.com/folke/flash.nvim" })

require("flash").setup()

vim.keymap.set({ "n", "x", "o" }, "<leader>m", function()
	require("flash").jump()
end, { desc = "Flash" })
