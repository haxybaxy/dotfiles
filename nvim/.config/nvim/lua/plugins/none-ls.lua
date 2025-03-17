return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local function is_django_project()
			-- Check for common Django project indicators
			local indicators = {
				"manage.py",
				"django_settings.py",
				"settings.py",
			}
			for _, file in ipairs(indicators) do
				local handle = io.popen(string.format("find . -name '%s' 2>/dev/null | head -n 1", file))
				if handle then
					local result = handle:read("*a")
					handle:close()
					if result and result ~= "" then
						return true
					end
				end
			end
			return false
		end

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
					extra_args = function()
						local args = {"--disable=C0111", "--generated-members=(cv2.*)"}
						return args
					end,
				}),
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
