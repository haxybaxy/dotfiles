return {
  { -- smoothscrolling
    "karb94/neoscroll.nvim",
    opts = {},
  },
  { -- cool looking vim.input and notifs
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        views = {
          cmdline_popup = {
            border = {
              style = "none",
              padding = { 2, 3 },
            },
            filter_options = {},
            win_options = {
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
          },
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  { -- keybind reminders + show marks and registers
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  { -- better looking window separators
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },

  { -- highlight todo comments like FIXME, TODO, etc.
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { -- show colors in the background
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "background",
    },
  },

  { -- render whitespace characters in visual mode
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    event = "ModeChanged *:[vV\22]",
    opts = {},
  },
}
