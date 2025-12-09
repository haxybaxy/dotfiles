local M = {}

M.setup = function(lspconfig, capabilities)
	-- Tailwind CSS
	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})

	-- CSS Language Server
	lspconfig.cssls.setup({
		capabilities = capabilities,
	})

	-- HTML Language Server
	lspconfig.html.setup({
		capabilities = capabilities,
		filetypes = { "html", "htmldjango" },
	})

	-- Emmet
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		filetypes = {
			"html",
			"htmldjango",
			"css",
			"scss",
			-- Removed JS/TS files to prevent aggressive HTML tag suggestions
			-- "javascript",
			-- "javascriptreact",
			-- "typescript",
			-- "typescriptreact",
		},
	})
end

return M

