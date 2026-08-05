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
			hide_by_name = { "thumbs.db", ".DS_Store", "__pycache__" }, -- only hide when gitignored
			never_show = { ".git" },
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
		},
	},
})
