-- Set before the plugin loads
vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_auto_close = 1
vim.g.mkdp_theme = "dark"

vim.pack.add({
	{
		src = "https://github.com/iamcco/markdown-preview.nvim.git",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("MarkdownPreviewKeys", { clear = true }),
	pattern = "markdown",
	callback = function(args)
		vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", {
			buffer = args.buf,
			desc = "Markdown Preview Toggle",
		})
	end,
})
