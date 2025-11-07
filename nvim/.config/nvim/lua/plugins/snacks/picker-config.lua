local layouts = require("plugins.snacks.picker.layouts").layouts
local sources = require("plugins.snacks.picker.sources").sources

local M = {}

M.picker = {
  exclude = {
    ".DS_Store",
    ".git",
    "node_modules",
    "ios",
    "android",
    "dist",
    ".next",
    "venv",
    ".expo",
    "__pycache__",
    "yarn.lock",
    ".yarn",
    ".ruff_cache"
  },
  ui_select = true,
  hidden = true,
  ignored = true,

  layouts = layouts,

  win = {
    preview = {
      wo = {
        number = true,
      },
    },
    input = {
      keys = {
        ["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
        ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["dd"] = "bufdelete",
        ["<c-v>"] = { "edit_vsplit", mode = { "n", "i" } },
      },
    },
    list = {
      keys = {
        ["<c-t>"] = "edit_tab",
      },
    },
  },

  sources = sources,
}

return M
