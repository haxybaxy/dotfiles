local M = {}

M.setup = function(lspconfig, capabilities)
	-- Typst Language Server
	lspconfig.tinymist.setup({
		capabilities = capabilities,
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onType",
			semanticTokens = "disable",
		},
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "<leader>tp", function()
				client:exec_cmd({
					title = "pin",
					command = "tinymist.pinMain",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}, { bufnr = bufnr })
			end, { desc = "[T]inymist [P]in", noremap = true })

			vim.keymap.set("n", "<leader>tu", function()
				client:exec_cmd({
					title = "unpin",
					command = "tinymist.pinMain",
					arguments = { vim.v.null },
				}, { bufnr = bufnr })
			end, { desc = "[T]inymist [U]npin", noremap = true })
		end,
	})
end

return M
