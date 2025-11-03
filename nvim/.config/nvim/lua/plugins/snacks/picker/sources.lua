local utils = require("plugins.snacks.picker.utils")

local M = {}

M.sources = {
  select = {
    layout = { preset = "flow" },
  },

  files = {
    hidden = true,
    ignored = true,
    layout = function()
      return utils.get_window_relative_flow_config()
    end,
  },

  grep = {
    layout = function()
      return utils.get_window_relative_flow_config()
    end,
  },

  recent = {
    layout = function()
      return utils.get_window_relative_flow_config()
    end,
  },

  lsp_references = {
    layout = function()
      return utils.get_window_relative_flow_config()
    end,
  },

  lsp_definitions = {
    layout = function()
      return utils.get_window_relative_flow_config()
    end,
  },

  buffers = {
    layout = function()
      return utils.get_window_relative_flow_config()
    end,
  },

  explorer = {
    include = { ".*", "hidden", "ignored" },
    layout = {
      layout = {
        backdrop = 80,
        position = "right",
        border = "none",
        box = "vertical",
        wo = {
          winhighlight = "WinSeparator:SnacksPickerList",
        },
        {
          win = "input",
          height = 1,
          border = "solid",
          title = "{title} {live} {flags}",
          title_pos = "center",
          wo = {
            winhighlight = "NormalFloat:SnacksPickerList,FloatBorder:SnacksPickerList,FloatTitle:SnacksPickerList",
          },
        },
        { win = "list",    border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
  },
}

return M
