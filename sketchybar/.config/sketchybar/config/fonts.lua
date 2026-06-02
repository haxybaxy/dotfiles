local dimens = require("config.dimens")

return {
	text = "MesloLGL Nerd Font",
	numbers = "MesloLGL Nerd Font",
	icons = function(size)
		local font = "sketchybar-app-font:Regular"
		return size and font .. ":" .. size or font .. ":" .. dimens.text.icon
	end,
	styles = {
		regular = "Regular",
		bold = "Bold",
	},
}
