return {
	{
	"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},

	{
	"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "cssls", "eslint", "graphql", "html", "jsonls" }
			})
		end
	},
	{
	"neovim/nvim-lspconfig",
		config  = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ts_ls.setup({})
			vim.keymap.set('n','K', vim.lsp.buf.hover, {}) -- show info in a hover
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {}) -- go to definition
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {}) -- go to references
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- perform code action
		end
	}
}
