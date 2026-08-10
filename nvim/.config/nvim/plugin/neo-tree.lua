vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")

require("neo-tree").setup({
	window = {
		position = "right",
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
		},
	},
	filesystem = {
		filtered_items = {
			visible = false, -- actually apply the filters below; `H` toggles them back on
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = { "thumbs.db", ".DS_Store" }, -- hidden, but `H` reveals them
			-- never_show entries are excluded from the tree AND from `/` search results,
			-- and cannot be toggled back on with `H`
			never_show = {
				".git",
				".venv",
				"venv",
				"node_modules",
				"__pycache__",
				".mypy_cache",
				".pytest_cache",
				".ruff_cache",
			},
		},
		-- neo-tree passes `--no-ignore` to fd (since hide_gitignored = false), so the
		-- `/` filter would otherwise walk straight into node_modules/.venv. Prune them.
		find_command = "fd",
		find_args = {
			fd = {
				"--exclude", ".git",
				"--exclude", ".venv",
				"--exclude", "venv",
				"--exclude", "node_modules",
				"--exclude", "__pycache__",
				"--exclude", ".mypy_cache",
				"--exclude", ".pytest_cache",
				"--exclude", ".ruff_cache",
			},
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
		},
	},
})
