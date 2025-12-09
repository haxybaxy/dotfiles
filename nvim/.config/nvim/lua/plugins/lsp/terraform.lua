local M = {}

M.setup = function(lspconfig, capabilities)
	-- Terraform Language Server
	lspconfig.terraformls.setup({
		capabilities = capabilities,
		filetypes = { "terraform", "tf", "hcl" },
	})
end

return M

