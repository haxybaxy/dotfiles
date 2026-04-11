vim.pack.add({
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/neotest-python",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
})

local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-python")({
			runner = "pytest",
			dap = { justMyCode = false },
		}),
	},
	output = { open_on_run = true },
	quickfix = { enabled = false },
})

local map = vim.keymap.set
map("n", "<leader>tn", function()
	neotest.run.run()
end, { desc = "Test nearest" })
map("n", "<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, { desc = "Test file" })
map("n", "<leader>ta", function()
	neotest.run.run(vim.fn.getcwd())
end, { desc = "Test all" })
map("n", "<leader>tl", function()
	neotest.run.run_last()
end, { desc = "Test last" })
map("n", "<leader>td", function()
	neotest.run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })
map("n", "<leader>tx", function()
	neotest.run.stop()
end, { desc = "Stop test" })
map("n", "<leader>ts", function()
	neotest.summary.toggle()
end, { desc = "Toggle summary" })
map("n", "<leader>to", function()
	neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Show output (float)" })
map("n", "<leader>tO", function()
	neotest.output_panel.toggle()
end, { desc = "Toggle output panel" })
map("n", "<leader>tw", function()
	neotest.watch.toggle(vim.fn.expand("%"))
end, { desc = "Watch file" })
map("n", "]t", function()
	neotest.jump.next({ status = "failed" })
end, { desc = "Next failed test" })
map("n", "[t", function()
	neotest.jump.prev({ status = "failed" })
end, { desc = "Previous failed test" })
