local M = {}

M.layouts = {
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
	explorer = {
		layout = {
			backdrop = 80,
			position = "right",
			border = "none",
			box = "vertical",
			wo = {
				winhighlight = "WinSeparator:SnacksPickerList",
			},
			{
				win = "input",
				height = 1,
				border = "solid",
				title = "{title} {live} {flags}",
				title_pos = "center",
				wo = {
					winhighlight = "NormalFloat:SnacksPickerList,FloatBorder:SnacksPickerList,FloatTitle:SnacksPickerList",
				},
			},
			{ win = "list", border = "none" },
			{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
		},
	},
}

return M


