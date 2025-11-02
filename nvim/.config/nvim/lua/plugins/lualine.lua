local mode_color = {
  n = '#7aa2f7',  -- Normal (blue)
  i = '#9ece6a',  -- Insert (green)
  v = '#bb9af7',  -- Visual (purple)
  V = '#bb9af7',  -- Visual Line
  [''] = '#bb9af7', -- Visual Block
  R = '#f7768e',  -- Replace (red)
  c = '#e0af68',  -- Command (yellow)
}

local function mode_text()
	local mode = vim.fn.mode()
	local mode_name = {
		n = "NOR",
		i = "INS",
		v = "VIS",
		V = "V-LINE",
		[""] = "V-BLOCK",
		c = "COMMAND",
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
						a = { fg = "#ffffff", bg = "none" },
						b = { fg = "#ffffff", bg = "none" },
						c = { fg = "#ffffff", bg = "none" },
					},
					insert = {
						a = { fg = "#ffffff", bg = "none" },
						b = { fg = "#ffffff", bg = "none" },
						c = { fg = "#ffffff", bg = "none" },
					},
					visual = {
						a = { fg = "#ffffff", bg = "none" },
						b = { fg = "#ffffff", bg = "none" },
						c = { fg = "#ffffff", bg = "none" },
					},
					replace = {
						a = { fg = "#ffffff", bg = "none" },
						b = { fg = "#ffffff", bg = "none" },
						c = { fg = "#ffffff", bg = "none" },
					},
					command = {
						a = { fg = "#ffffff", bg = "none" },
						b = { fg = "#ffffff", bg = "none" },
						c = { fg = "#ffffff", bg = "none" },
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
							return { fg = mode_color[vim.fn.mode()] or "#ffffff", bg = "none" }
						end,
					},
				},
        lualine_b = {'filename'},
				lualine_c = { "diagnostics" },
				lualine_x = {
					{ -- when using noice, add this section to show macro recording status
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
					},
				},
				lualine_y = { "branch" },
				lualine_z = { "progress" },
			},
		})
	end,
}
