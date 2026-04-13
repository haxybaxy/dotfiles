vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("fzf-lua").setup({
	actions = {
		files = {
			["enter"] = FzfLua.actions.file_edit_or_qf,
			["ctrl-s"] = FzfLua.actions.file_split,
			["ctrl-v"] = FzfLua.actions.file_vsplit,
			["ctrl-t"] = FzfLua.actions.file_tabedit,
			["ctrl-q"] = FzfLua.actions.file_sel_to_qf,
			["ctrl-Q"] = FzfLua.actions.file_sel_to_ll,
			["alt-i"] = FzfLua.actions.toggle_ignore,
			["ctrl-h"] = FzfLua.actions.toggle_hidden,
			["ctrl-f"] = FzfLua.actions.toggle_follow,
		},
	},
	files = {
		fd_opts = "--color=never --type f --hidden --follow --no-ignore --exclude .git --exclude '*.pdf' --exclude node_modules --exclude .venv  --exclude venv --exclude __pycache__",
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git' --glob '!node_modules' --glob '!venv' --glob '!__pycache__'",
	},
})

vim.keymap.set("n", "<leader><space>", function()
	require("fzf-lua").live_grep()
end, { desc = "Ripgrep" })

vim.keymap.set("n", "<leader>f", function()
	require("fzf-lua").files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>x", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Workspace Diagnostics" })

vim.keymap.set("n", "<leader>r", function()
	require("fzf-lua").oldfiles()
end, { desc = "Recent" })

vim.keymap.set("n", "<leader>gd", function()
	require("fzf-lua").lsp_definitions()
end, { desc = "LSP Definitions" })

vim.keymap.set("n", "<leader>gr", function()
	require("fzf-lua").lsp_references()
end, { desc = "LSP References" })

vim.keymap.set("n", "<leader>bf", function()
	require("fzf-lua").buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>sH", function()
	require("fzf-lua").highlights()
end, { desc = "Highlights" })
