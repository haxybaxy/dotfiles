return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"json",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"yaml",
				"toml",
				"markdown",
				"markdown_inline",
				"csv",
				"graphql",
				"dockerfile",
				"gitignore",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true },
		})
	end,
} -- syntax highlighting
