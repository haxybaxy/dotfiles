local M = {}

M.setup = function(lspconfig, capabilities)
	lspconfig.jsonls.setup({
		capabilities = capabilities,
	})
end

return M

