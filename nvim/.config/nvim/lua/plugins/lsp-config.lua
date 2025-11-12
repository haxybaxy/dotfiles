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
					"ts_ls",
					"tailwindcss",
					"cssls",
					"eslint",
					"graphql",
					"html",
					"jsonls",
					"emmet_ls",
					"basedpyright",
					"ruff",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

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

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
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

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				settings = {
					workingDirectories = { mode = "auto" },
				},
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "htmldjango" },
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

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

			lspconfig.ruff.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show info in a hover" })
			-- Using snacks picker instead of the native qflist for these
			-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Perform code action" })
			vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to definition" })
			vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, { desc = "Show diagnostics" })
		end,
	},
}
