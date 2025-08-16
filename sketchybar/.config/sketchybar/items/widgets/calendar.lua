local constants = require("constants")
local icons = require("config.icons")

local function get_clock_icon()
	local hour = tonumber(os.date("%H"))
	local hour_12 = hour % 12
	if hour_12 == 0 then
		hour_12 = 12
	end

	return icons.text.clock["_" .. hour_12] or "?"
end

local calendar = sbar.add("item", constants.items.CALENDAR, {
	position = "right",
	update_freq = 1,
	icon = { string = get_clock_icon() },
	label = { padding_left = 0 },
})

calendar:subscribe({ "forced", "routine", "system_woke" }, function(env)
	calendar:set({
		icon = { string = get_clock_icon() },
		label = { string = os.date("%H:%M") },
	})
end)

calendar:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Calendar'")
end)
