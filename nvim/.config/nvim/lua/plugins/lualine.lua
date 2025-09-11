return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local colors = require("catppuccin.palettes").get_palette("mocha") -- or your flavor

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config base
    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = {
          normal = { c = { fg = colors.text, bg = "None" } },
          inactive = { c = { fg = colors.overlay1, bg = "None" } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- Left side
    ins_left {
      function() return "" end,
      color = function()
        local mode_color = {
          n = colors.red, i = colors.green, v = colors.blue,
          [""] = colors.blue, V = colors.blue, c = colors.mauve,
          no = colors.red, s = colors.peach, S = colors.peach,
          [""] = colors.peach, ic = colors.yellow, R = colors.lavender,
          Rv = colors.lavender, cv = colors.red, ce = colors.red,
          r = colors.sky, rm = colors.sky, ["r?"] = colors.sky,
          ["!"] = colors.red, t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    ins_left { "filesize", cond = conditions.buffer_not_empty }

    ins_left {
      "filename",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.mauve, gui = "bold" },
    }

    ins_left { "location" }

    ins_left { "progress", color = { fg = colors.text, gui = "bold" } }

    ins_left {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.sky },
      },
    }

    -- Right side
    ins_right {
      "branch",
      icon = "",
      color = { fg = colors.mauve, gui = "bold" },
    }

    ins_right {
      "diff",
      symbols = { added = " ", modified = "󰝤 ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.peach },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    -- Initialize lualine
    lualine.setup(config)
  end,
}

