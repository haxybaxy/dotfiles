local constants = require("constants")
local settings = require("config.settings")
local colors = require("config.colors")

local spaces = {}
local monitors = {}

local swapWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- copy "Icons" from the nerd fonts cheat sheet and replace icon and name accordingly below
-- https://www.nerdfonts.com/cheat-sheet
local spaceConfigs = {
  ["1"] = { icon = "󰘧", name = "term" },
  ["2"] = { icon = "󰖟", name = "web" },
  ["3"] = { icon = "󰋎", name = "chat" },
  ["4"] = { icon = "󰃢", name = "org" },
  ["5"] = { icon = "󱗂", name = "misc" },
  ["6"] = { icon = "󰓠", name = "extra" },
}

local function selectCurrentWorkspace(focusedWorkspaceName)
  for sid, item in pairs(spaces) do
    if item ~= nil then
      local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName
      item:set({
        icon = { color = colors.white },
        label = {
          color = colors.white,
          width = isSelected and "dynamic" or 0,
        },
        background = {
          color = colors.bg1,
          border_color = isSelected and colors.white or colors.grey,
          border_width = 1,
        },
      })
    end
  end

  sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
  sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
    local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
    selectCurrentWorkspace(focusedWorkspaceName)
  end)
end

local function addWorkspaceItem(workspaceName, monitorId)
  local spaceName = constants.items.SPACES .. "." .. workspaceName
  local spaceConfig = spaceConfigs[workspaceName] or spaceConfigs["1"] -- fallback to term 

  spaces[spaceName] = sbar.add("item", spaceName, {
    label = {
      width = 0,
      padding_left = 0,
      string = spaceConfig.name,
    },
    icon = {
      string = spaceConfig.icon or settings.icons.apps["default"],
      color = colors.white,
    },
    background = {
      color = colors.bg1,
    },
    display = monitorId, -- Assign to specific monitor
    click_script = "aerospace workspace " .. workspaceName,
  })

  sbar.add("item", spaceName .. ".padding", {
    width = settings.dimens.padding.label,
    display = monitorId, -- Assign padding to same monitor
  })
end

local function createWorkspacesForMonitor(monitorId)
  local command = constants.aerospace.LIST_WORKSPACES_FOR_MONITOR .. " " .. monitorId
  sbar.exec(command, function(workspacesOutput)
    for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
      if workspaceName ~= "" then
        addWorkspaceItem(workspaceName, monitorId)
      end
    end
  end)
end

local function createWorkspacesForAllMonitors()
  sbar.exec(constants.aerospace.LIST_MONITORS, function(monitorsOutput)
    for monitorLine in monitorsOutput:gmatch("[^\r\n]+") do
      if monitorLine ~= "" then
        -- Extract monitor ID from the line (first field)
        local monitorId = monitorLine:match("^(%S+)")
        if monitorId then
          monitors[#monitors + 1] = monitorId
          createWorkspacesForMonitor(monitorId)
        end
      end
    end

    -- After creating all workspaces, select the current one
    findAndSelectCurrentWorkspace()
  end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
  local isShowingSpaces = env.isShowingMenu == "off" and true or false
  sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
  selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
  sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

-- Also subscribe to display changes to handle monitor connections/disconnections
local displayWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

displayWatcher:subscribe("display_change", function()
  -- Clear existing spaces
  for sid, item in pairs(spaces) do
    if item ~= nil then
      sbar.remove(sid)
      sbar.remove(sid .. ".padding")
    end
  end
  spaces = {}
  monitors = {}

  -- Recreate workspaces for all monitors
  createWorkspacesForAllMonitors()
end)

createWorkspacesForAllMonitors()
