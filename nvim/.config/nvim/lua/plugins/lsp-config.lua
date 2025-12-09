return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tailwindcss",
					"cssls",
					"eslint",
					"graphql",
					"html",
					"jsonls",
					"emmet_ls",
					"basedpyright",
					"ruff",
					"terraformls",
					"clangd",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Load language-specific LSP configurations
			local lua_lsp = require("plugins.lsp.lua")
			local typescript_lsp = require("plugins.lsp.typescript")
			local python_lsp = require("plugins.lsp.python")
			local web_lsp = require("plugins.lsp.web")
			local json_lsp = require("plugins.lsp.json")
			local eslint_lsp = require("plugins.lsp.eslint")
			local terraform_lsp = require("plugins.lsp.terraform")
			local cpp_lsp = require("plugins.lsp.cpp")

			-- Setup all language servers
			lua_lsp.setup(lspconfig, capabilities)
			typescript_lsp.setup(lspconfig, capabilities)
			python_lsp.setup(lspconfig, capabilities)
			web_lsp.setup(lspconfig, capabilities)
			json_lsp.setup(lspconfig, capabilities)
			eslint_lsp.setup(lspconfig, capabilities)
			terraform_lsp.setup(lspconfig, capabilities)
			cpp_lsp.setup(lspconfig, capabilities)

			-- LSP Keymaps (centralized)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show info in a hover" })
			-- Using snacks picker instead of the native qflist for these
			-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "Toggle Inlay Hints" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Perform code action" })
			vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to definition" })
			vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, { desc = "Show diagnostics" })
		end,
	},
}
