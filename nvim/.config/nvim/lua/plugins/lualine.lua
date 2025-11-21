local function mode_text()
	local mode = vim.fn.mode()
	local mode_name = {
		n = "NOR",
		i = "INS",
		v = "VIS",
		V = "V-LINE",
		[""] = "V-BLOCK",
		c = "COM",
		R = "REPLACE",
	}
	return mode_name[mode] or mode
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = {
					normal = {
						a = { bg = "none" },
						b = { bg = "none" },
						c = { bg = "none" },
					},
					insert = {
						a = { bg = "none" },
						b = { bg = "none" },
						c = { bg = "none" },
					},
					visual = {
						a = { bg = "none" },
						b = { bg = "none" },
						c = { bg = "none" },
					},
					replace = {
						a = { bg = "none" },
						b = { bg = "none" },
						c = { bg = "none" },
					},
					command = {
						a = { bg = "none" },
						b = { bg = "none" },
						c = { bg = "none" },
					},
					inactive = {
						a = { fg = "#888888", bg = "none" },
						b = { fg = "#888888", bg = "none" },
						c = { fg = "#888888", bg = "none" },
					},
				},
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_divide_middle = false,
			},
			sections = {
				lualine_a = {
					{
						mode_text,
						color = function()
							return { bg = "none" }
						end,
					},
				},
				lualine_b = { {"filename"} },
        lualine_c = {},
				lualine_x = {
					{ -- when using noice, add this section to show macro recording status
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
					},
				},
				lualine_y = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = "● ",
							warn = "● ",
							info = "● ",
							hint = "● ",
						},
						diagnostics_color = {
							error = { fg = "#e06c75" },
							warn = { fg = "#e5c07b" },
							info = { fg = "#61afef" },
							hint = { fg = "#56b6c2" },
						},
					},
					"branch",
				},
				lualine_z = { "location" },
			},
		})
	end,
}
