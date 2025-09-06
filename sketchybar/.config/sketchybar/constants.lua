local events = {
  AEROSPACE_WORKSPACE_CHANGED = "aerospace_workspace_changed",
  AEROSPACE_SWITCH = "aerospace_switch",
  FRONT_APP_SWITCHED = "front_app_switched",
  UPDATE_WINDOWS = "update_windows",
}

local items = {
  SPACES = "workspaces",
  FRONT_APPS = "front_apps",
  MEDIA = "widgets.media",
  VOLUME = "widgets.volume",
  BATTERY = "widgets.battery",
  CALENDAR = "widgets.calendar",
}

local aerospace = {
  LIST_ALL_WORKSPACES = "aerospace list-workspaces --all",
  GET_CURRENT_WORKSPACE = "aerospace list-workspaces --focused",
  LIST_WINDOWS = 'aerospace list-windows --workspace focused --format "id=%{window-id}, name=%{app-name}"',
  LIST_WINDOWS_WITH_MONITOR = 'aerospace list-windows --workspace focused --format "id=%{window-id}, name=%{app-name}, monitor=%{monitor-appkit-nsscreen-screens-id}"',
  GET_CURRENT_WINDOW = "aerospace list-windows --focused --format %{app-name}",
  GET_FOCUSED_MONITOR = "aerospace list-monitors --focused --format %{monitor-appkit-nsscreen-screens-id}",
  LIST_MONITORS = "aerospace list-monitors",
  LIST_WORKSPACES_FOR_MONITOR = "aerospace list-workspaces --monitor",
}

return {
  items = items,
  events = events,
  aerospace = aerospace,
}
