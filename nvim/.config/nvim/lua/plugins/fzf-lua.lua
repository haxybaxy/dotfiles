return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {},
	---@diagnostic enable: missing-fields
	keys = {
		{ "<leader><space>", function() require("fzf-lua").live_grep() end, desc = "Ripgrep" },
		{ "<leader>f", function() require("fzf-lua").files() end, desc = "Find Files" },
		{ "<leader>r", function() require("fzf-lua").oldfiles() end, desc = "Recent" },
		{ "<leader>gd", function() require("fzf-lua").lsp_definitions() end, desc = "LSP Definitions" },
		{ "<leader>gr", function() require("fzf-lua").lsp_references() end, desc = "LSP References" },
		{ "<leader>bf", function() require("fzf-lua").buffers() end, desc = "Buffers" },
		{ "<leader>sH", function() require("fzf-lua").highlights() end, desc = "Highlights" },
	},
}
