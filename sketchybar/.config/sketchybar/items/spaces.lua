local constants = require("constants")
local colors = require("config.colors")

local spaces = {}
local modeIndicator = nil

local currentWorkspaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local modeWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function createModeIndicator()
	modeIndicator = sbar.add("item", constants.items.MODE_INDICATOR, {
		icon = {
			string = "?",
			padding_right = 0,
		},
	})
end

local function createSpaces()
	for i = 1, 5 do
		local spaceName = constants.items.SPACES .. "." .. i

		spaces[spaceName] = sbar.add("item", spaceName, {
			icon = {
				string = "●",
				font = {
					size = 16.0,
				},
				color = colors.white,
				padding_left = 0,
				padding_right = 2,
			},
			padding_left = 2,
			padding_right = 0,
			click_script = "aerospace workspace " .. i,
		})
	end
end

local function selectCurrentWorkspace(focusedWorkspaceName)
	for i = 1, 5 do
		local spaceName = constants.items.SPACES .. "." .. i
		local item = spaces[spaceName]

		if item ~= nil then
			local isSelected = tostring(i) == focusedWorkspaceName
			item:set({
				icon = {
					string = isSelected and "" or "",
					color = isSelected and colors.orange or colors.white,
				},
			})
		end
	end
end

local function updateModeIndicator(currentMode)
	if modeIndicator ~= nil then
		local mode = currentMode or "main"
		local displayLetter = mode == "main" and "" or mode == "service" and "" or "?"
		local modeColor = mode == "main" and colors.white or colors.orange

		modeIndicator:set({
			icon = {
				string = displayLetter,
				color = modeColor,
			},
		})
	end
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
end)

modeWatcher:subscribe(constants.events.AEROSPACE_MODE_CHANGED, function(env)
	updateModeIndicator(env.CURRENT_MODE)
end)

local function initializeModeIndicator()
	sbar.exec(constants.aerospace.GET_CURRENT_MODE, function(modeOutput)
		local currentMode = modeOutput:match("[^\r\n]+")
		updateModeIndicator(currentMode)
	end)
end

createModeIndicator()
createSpaces()
findAndSelectCurrentWorkspace()
initializeModeIndicator()
