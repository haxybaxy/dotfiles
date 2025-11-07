return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jay-babu/mason-null-ls.nvim",
	},

	config = function()
		local null_ls = require("null-ls")
		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"ruff",
			},
			automatic_installation = true,
		})

		null_ls.setup({
			sources = {
				require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
				require("none-ls.formatting.ruff_format"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
			},

			on_attach = function(client, bufnr) -- Add formatting on save
				-- Enable format on save if the LSP supports it
				if client.supports_method("textDocument/formatting") then
					local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format code with LSP" })
	end,
}
