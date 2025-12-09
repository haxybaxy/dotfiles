local M = {}

M.setup = function(lspconfig, capabilities)
	-- Ruff LSP for linting
	lspconfig.ruff.setup({
		capabilities = capabilities,
	})

	-- Basedpyright for type checking and completions
	lspconfig.basedpyright.setup({
		capabilities = capabilities,
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "strict", -- or "standard" or "strict"
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
			python = {
				analysis = {
					inlayHints = {
						variableTypes = true,
						functionReturnTypes = true,
						callArgumentNames = true,
						pytestParameters = true,
					},
				},
			},
		},
		on_attach = function(client, bufnr)
			-- Enable inlay hints for this buffer
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	})
end

return M

