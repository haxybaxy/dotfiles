vim.keymap.set("n", "<leader>tS", function()
	require("neotest").run.run({ extra_args = { "-s", "--no-cov" } })
end, { buffer = 0, desc = "Run nearest test with stdout" })
