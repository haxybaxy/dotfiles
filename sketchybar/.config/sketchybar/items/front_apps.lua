local constants = require("constants")
local settings = require("config.settings")
local icons = require("config.icons")

local frontApps = {}

sbar.add("bracket", constants.items.FRONT_APPS, {}, {
	position = "left",
	display = "active", -- Show bracket only on active monitor
})

local frontAppWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function selectFocusedWindow(frontAppName)
	for appName, app in pairs(frontApps) do
		local isSelected = appName == frontAppName
		local color = isSelected and settings.colors.orange or settings.colors.white
		app:set({
			label = { color = color },
			icon = { color = color },
		})
	end
end

local function updateWindows(windows)
	sbar.remove("/" .. constants.items.FRONT_APPS .. "\\.*/")

	frontApps = {}
	-- App names can hold any character (e.g. "zoom.us", "哔哩哔哩"), so match up to the next field
	for windowId, windowName, monitorId in string.gmatch(windows, "id=(%d+), name=([^\n]+), monitor=([^\n]+)") do
		local icon = icons.apps[windowName] or settings.icons.apps["default"]

		frontApps[windowName] = sbar.add("item", constants.items.FRONT_APPS .. "." .. windowName, {
			label = {
				padding_left = 0,
				string = string.lower(windowName),
			},
			icon = {
				string = icon,
				font = settings.fonts.icons(16),
			},
			display = monitorId, -- Show app only on its assigned monitor
			click_script = "aerospace focus --window-id " .. windowId,
		})

		frontApps[windowName]:subscribe(constants.events.FRONT_APP_SWITCHED, function(env)
			selectFocusedWindow(env.INFO)
		end)
	end

	sbar.exec(constants.aerospace.GET_CURRENT_WINDOW, function(frontAppName)
		selectFocusedWindow(frontAppName:gsub("[\n\r]", ""))
	end)
end

local function getWindows()
	sbar.exec(constants.aerospace.LIST_WINDOWS_WITH_MONITOR, updateWindows)
end

frontAppWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
	getWindows()
end)

-- Handle monitor changes - refresh front apps when displays change
local displayWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

displayWatcher:subscribe("display_change", function()
	getWindows()
end)

getWindows()
