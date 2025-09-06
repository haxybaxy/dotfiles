local constants = require("constants")
local colors = require("config.colors")
local icons = require("config.icons")

local spaces = {}

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
			item:set({
				icon = {
					string = isSelected and icons.text.spaces.active or icons.text.spaces.inactive,
					color = isSelected and colors.orange or colors.white,
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

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
end)

createSpaces()
findAndSelectCurrentWorkspace()
