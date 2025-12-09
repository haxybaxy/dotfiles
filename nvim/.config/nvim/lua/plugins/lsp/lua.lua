local M = {}

M.setup = function(lspconfig, capabilities)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" }, -- Recognize 'vim' as a global variable
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
				},
				telemetry = {
					enable = false, -- Disable telemetry
				},
			},
		},
	})
end

return M

