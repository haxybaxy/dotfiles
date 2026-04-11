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
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
		},
	},
})
