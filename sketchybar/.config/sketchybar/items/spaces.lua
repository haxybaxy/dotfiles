local constants = require("constants")
local colors = require("config.colors")
local icons = require("config.icons")

local spaces = {}
local currentMode = "main"  -- Track current aerospace mode

local currentWorkspaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function createSpaces()
	for i = 1, 5 do
		local spaceName = constants.items.SPACES .. "." .. i

		spaces[spaceName] = sbar.add("item", spaceName, {
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
			local activeColor = currentMode == "main" and colors.orange or colors.purple
			item:set({
				icon = {
					string = isSelected and icons.text.spaces.active or icons.text.spaces.inactive,
					color = isSelected and activeColor or colors.white,
				},
			})
		end
	end
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function updateMode(mode)
	currentMode = mode
	-- Directly update colors for all workspace items without async call
	for i = 1, 5 do
		local spaceName = constants.items.SPACES .. "." .. i
		local item = spaces[spaceName]
		if item ~= nil then
			-- Get current icon to determine if this workspace is active
			local currentIcon = item:query().icon.value
			local isActive = currentIcon == icons.text.spaces.active
			if isActive then
				local activeColor = currentMode == "main" and colors.orange or colors.purple
				item:set({
					icon = {
						color = activeColor,
					},
				})
			end
		end
	end
end

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_MODE_CHANGED, function(env)
	updateMode(env.CURRENT_MODE)
end)

local function initializeMode()
	sbar.exec(constants.aerospace.GET_CURRENT_MODE, function(modeOutput)
		local mode = modeOutput:match("[^\r\n]+")
		updateMode(mode)
	end)
end

createSpaces()
findAndSelectCurrentWorkspace()
initializeMode()
