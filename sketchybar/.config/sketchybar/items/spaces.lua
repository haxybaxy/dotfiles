local constants = require("constants")
local colors = require("config.colors")
local icons = require("config.icons")

local spaces = {}
local currentMode = "main"
local focusedWorkspace = "1"

local WORKSPACE_COUNT = 5
local ACTIVE_ICON = icons.text.spaces.active
local INACTIVE_ICON = icons.text.spaces.inactive

local function getWorkspaceColors(isActive, mode)
	if isActive then
		return mode == "main" and colors.orange or colors.green
	else
		return mode == "main" and colors.white or colors.purple
	end
end

local function updateWorkspaceDisplay(workspaceId, isActive)
	local spaceName = constants.items.SPACES .. "." .. workspaceId
	local item = spaces[spaceName]

	if item then
		item:set({
			icon = {
				string = isActive and ACTIVE_ICON or INACTIVE_ICON,
				color = getWorkspaceColors(isActive, currentMode),
			},
		})
	end
end

local function updateAllWorkspaces()
	for i = 1, WORKSPACE_COUNT do
		local isActive = tostring(i) == focusedWorkspace
		updateWorkspaceDisplay(i, isActive)
	end
end

local function onWorkspaceChanged(newWorkspace)
	local oldWorkspace = focusedWorkspace
	focusedWorkspace = newWorkspace

	if oldWorkspace ~= newWorkspace then
		updateWorkspaceDisplay(tonumber(oldWorkspace), false)
		updateWorkspaceDisplay(tonumber(newWorkspace), true)
	end
end

local function onModeChanged(newMode)
	currentMode = newMode
	updateAllWorkspaces()
end

local function createSpaces()
	for i = 1, WORKSPACE_COUNT do
		local spaceName = constants.items.SPACES .. "." .. i
		spaces[spaceName] = sbar.add("item", spaceName, {
			icon = {
				string = INACTIVE_ICON,
				color = colors.white,
			},
			click_script = "aerospace workspace " .. i,
		})
	end
end

local function initialize()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(output)
		focusedWorkspace = output:match("[^\r\n]+") or "1"

		sbar.exec(constants.aerospace.GET_CURRENT_MODE, function(modeOutput)
			currentMode = modeOutput:match("[^\r\n]+") or "main"

			updateAllWorkspaces()
		end)
	end)
end

local watcher = sbar.add("item", { drawing = false, updates = true })

watcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	onWorkspaceChanged(env.FOCUSED_WORKSPACE)
end)

watcher:subscribe(constants.events.AEROSPACE_MODE_CHANGED, function(env)
	onModeChanged(env.CURRENT_MODE)
end)

createSpaces()
initialize()
