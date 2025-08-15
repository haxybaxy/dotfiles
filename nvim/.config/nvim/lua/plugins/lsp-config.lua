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
					"pyright",
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
				settings = {
					typescript = {
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
			})

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        rootpatterns = {
          "package.json",
          "tsconfig.json",
          "jsconfig.json",
          ".git",
        },
      })

			 lspconfig.eslint.setup({
			 	capabilities = capabilities,
			 	settings = {
			 		workingDirectories = { mode = "auto" },
			 	},
			 })

			lspconfig.graphql.setup({
				capabilities = capabilities,
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

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.ruff.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- show info in a hover
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {}) -- go to definition
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {}) -- go to references
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- perform code action
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {}) -- rename symbol
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {}) -- go to type definition
			vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, {}) -- show diagnostics
		end,
	},
}
