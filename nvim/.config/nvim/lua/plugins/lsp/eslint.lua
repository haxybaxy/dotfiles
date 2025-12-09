local M = {}

M.setup = function(lspconfig, capabilities)
	lspconfig.eslint.setup({
		capabilities = capabilities,
		settings = {
			workingDirectories = { mode = "auto" },
		},
	})
end

return M

