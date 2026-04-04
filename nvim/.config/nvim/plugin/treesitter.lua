vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local treesitter = require("nvim-treesitter")
treesitter.setup({})

local ensure_installed = {
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
}

local config = require("nvim-treesitter.config")
local already_installed = config.get_installed()
local parsers_to_install = {}

for _, parser in ipairs(ensure_installed) do
	if not vim.tbl_contains(already_installed, parser) then
		table.insert(parsers_to_install, parser)
	end
end

if #parsers_to_install > 0 then
	treesitter.install(parsers_to_install)
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true }),
	callback = function(args)
		if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
			vim.treesitter.start(args.buf)
		end
	end,
})

require("treesitter-context").setup({
	max_lines = 3,
})
