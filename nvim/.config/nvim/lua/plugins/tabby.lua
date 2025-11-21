return {
	"nanozuki/tabby.nvim",
	config = function()
		local theme = {
			fill = "TabLineFill",
			current_tab = "TabLine",
			tab = "NonText",
			line_sep = "Cursor",
		}

		require("tabby.tabline").set(function(line)
			return {
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab

					-- this plugin uses the background color of the highlight groups as the foreground of the symbol
					local left_sep

					if tab.is_current() then
						left_sep = line.sep("▎", theme.line_sep, theme.current_tab)
					else
						left_sep = line.sep("▎", theme.fill, theme.fill)
					end

					return {
						left_sep,
						tab.number(),
						tab.name(),
						line.sep(" ", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				hl = theme.fill,
			}
		end)
	end,
}
