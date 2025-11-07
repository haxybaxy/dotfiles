return {
	"nanozuki/tabby.nvim",
	config = function()
		local theme = {
			fill = "TabLineFill",
			current_tab = "TabLine",
			tab = "NonText",
			bookmark = "BookMarkLine",
		}

		require("tabby.tabline").set(function(line)
			return {
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					local left_sep
					if tab.is_current() then
						left_sep = line.sep("▎", theme.tab, theme.current_tab)
					else
						left_sep = line.sep("▎", theme.fill, theme.fill)
					end

					return {
						left_sep,
						tab.number(),
						tab.name(),
						line.sep(" ", hl, theme.fill), -- trailing spacer for the tab
						hl = hl,
						margin = " ",
					}
				end),
				hl = theme.fill,
			}
		end)
	end,
}
