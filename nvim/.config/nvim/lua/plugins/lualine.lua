return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
        theme = "onedark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_divide_middle = false,
			},
		})
	end,
}
