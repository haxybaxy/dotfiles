return {
	"echasnovski/mini.files",
	opts = {},
	keys = {
		{
			"<leader>e",
			function()
				if not require("mini.files").close() then
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end
			end,
			desc = "File Explorer",
		},
	},
}
