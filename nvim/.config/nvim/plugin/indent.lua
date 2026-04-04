vim.pack.add({ "https://github.com/saghen/blink.indent" })
require("blink.indent").setup({
	static = {
		char = "▏", -- skinnier indent line
	},
	scope = {
		char = "▏",
	},
})
