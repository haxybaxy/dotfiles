local utils = require("plugins.snacks.picker.utils")

local M = {}

M.sources = {
	select = {
		layout = { preset = "flow" },
	},

	files = {
		hidden = true,
		ignored = true,
		layout = function()
			return utils.get_window_relative_flow_config()
		end,
	},

	grep = {
		layout = function()
			return utils.get_window_relative_flow_config()
		end,
	},

	recent = {
		layout = function()
			return utils.get_window_relative_flow_config()
		end,
	},

	buffers = {
		layout = function()
			return utils.get_window_relative_flow_config()
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
}

return M


