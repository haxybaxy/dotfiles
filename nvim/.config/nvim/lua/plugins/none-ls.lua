return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local function find_django_settings()
			local handle = io.popen("find . -name settings.py | head -n 1")
			if handle then
				local result = handle:read("*a")
				handle:close()
				if result and result ~= "" then
					result = result:gsub("%./", "") -- Remove leading "./"
					result = result:gsub("/settings.py", "") -- Remove file name
					result = result.gsub(result, "%s+", "")
					return result:gsub("/", ".") .. ".settings" -- Convert to module format
				end
			end
			return "main.settings" -- Default fallback
		end

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.completion.spell,
				require("none-ls.diagnostics.eslint"),
				null_ls.builtins.diagnostics.pylint.with({
					command = "pylint",
					debounce = 100,
					extra_args = {
						"--disable=C0111",
						"--load-plugins=pylint_django",
						"--django-settings-module=" .. find_django_settings(),
					},
				}),
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
