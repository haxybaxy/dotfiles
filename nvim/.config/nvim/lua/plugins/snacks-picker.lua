local M = {}
function M.get_window_relative_flow_config()
	local win = vim.api.nvim_get_current_win()
	local win_config = vim.api.nvim_win_get_config(win)
	local win_pos = vim.api.nvim_win_get_position(win)
	local win_width = vim.api.nvim_win_get_width(win)
	local win_height = vim.api.nvim_win_get_height(win)

	-- Get editor dimensions
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines

	-- Calculate window position in editor coordinates
	local win_col = win_pos[2]
	local win_row = win_pos[1]

	-- If it's a floating window, use its absolute position
	if win_config.relative and win_config.relative ~= "" then
		win_col = win_config.col or win_col
		win_row = win_config.row or win_row
	end

	-- Calculate picker dimensions relative to current window
	local picker_width = math.min(win_width - 4, math.floor(editor_width * 0.4)) -- Use window width but cap it
	local picker_height = math.floor(win_height * 0.3) -- 30% of window height for bottom third

	-- Position picker centered horizontally within the current window, in the bottom third
	local target_col = win_col + math.floor((win_width - picker_width) / 2)
	local target_row = win_row + math.floor(win_height * 0.67) -- Start at 67% down the window

	-- Ensure picker doesn't go off screen
	if target_col < 0 then
		target_col = 0
	end
	if target_col + picker_width > editor_width then
		target_col = editor_width - picker_width
	end
	if target_row < 0 then
		target_row = 0
	end
	if target_row + picker_height > editor_height then
		target_row = editor_height - picker_height
	end

	-- Return the proper layout structure that Snacks expects
	return {
		preview = "main",
		layout = {
			backdrop = false,
			col = target_col,
			width = picker_width,
			min_width = 50,
			row = target_row,
			height = picker_height,
			min_height = 10,
			box = "vertical",
			border = "solid",
			title = "{title} {live} {flags}",
			title_pos = "center",
			{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
			{ win = "input", height = 1, border = "solid" },
			{ win = "list", border = "none" },
		},
	}
end

return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			exclude = {
        ".DS_Store",
				".git",
				"node_modules",
				"ios",
				"android",
				"dist",
			},
			ui_select = true,
			hidden = true,
			ignored = true,

			layouts = {
				default = {
					layout = {
						box = "vertical",
						width = 0.9,
						min_width = 120,
						height = 0.8,
						{
							box = "vertical",
							border = "solid",
							title = "{title} {live} {flags}",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
						{ win = "preview", title = "{preview}", border = "solid" },
					},
				},
				ivy = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.4,
						border = "solid",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
				float = {
					preview = "main",
					layout = {
						position = "float",
						width = 60,
						col = 0.15,
						min_width = 60,
						height = 0.85,
						min_height = 25,
						box = "vertical",
						border = "solid",
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
					},
				},
				flow = {
					preview = "main",
					layout = {
						backdrop = false,
						col = 5,
						width = 0.35,
						min_width = 50,
						row = 0.65,
						height = 0.30,
						min_height = 10,
						box = "vertical",
						border = "solid",
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						{ win = "input", height = 1, border = "solid" },
						{ win = "list", border = "none" },
					},
				},
				left_bottom_corner = {
					preview = "main",
					layout = {
						width = 0.5,
						min_width = 0.35,
						height = 0.35,
						min_height = 0.35,
						row = 0.5,
						col = 10,
						border = "solid",
						box = "vertical",
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						{ win = "input", height = 1, border = "solid" },
						{ win = "list", border = "none" },
					},
				},
				sidebar_right = {
					preview = "main",
					layout = {
						backdrop = false,
						width = 40,
						min_width = 40,
						height = 0,
						position = "right",
						border = "none",
						box = "vertical",
						{
							win = "input",
							height = 1,
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
			},

			win = {
				preview = {
					wo = {
						number = false,
					},
				},
				input = {
					keys = {
						["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
						["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
					},
				},
				list = {
					keys = {
						["<c-t>"] = "edit_tab",
					},
				},
			},

			sources = {
				select = {
					layout = { preset = "flow" },
				},

				files = {
          hidden = true,
          ignored = true,
					layout = function()
						return M.get_window_relative_flow_config()
					end,
				},

        grep = {
          layout = function()
            return M.get_window_relative_flow_config()
          end,
        },

        recent = {
          layout = function()
            return M.get_window_relative_flow_config()
          end,
        },

        buffers = {
          layout = function()
            return M.get_window_relative_flow_config()
          end,
        },

				explorer = {
					include = { ".*", "hidden", "ignored" },
					layout = {
						layout = {
							position = "right",
						},
					},
				},
			},
		},
	},
}
