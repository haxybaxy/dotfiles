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
              winhighlight = "NormalFloat:StatusLine,FloatBorder:StatusLine",
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
    config = function()
      local wk = require("which-key")
      wk.setup({
        triggers = {
          { "<leader>", mode = { "n", "v" } }
        },
      })
      wk.add({
        { "<leader>t",  group = "tabs" },
        { "<leader>tn", desc = "New Tab" },
        { "<leader>tx", desc = "Close Tab" },
        { "<leader>1",  desc = "Tab 1",    hidden = true },
        { "<leader>2",  desc = "Tab 2",    hidden = true },
        { "<leader>3",  desc = "Tab 3",    hidden = true },
        { "<leader>4",  desc = "Tab 4",    hidden = true },
        { "<leader>5",  desc = "Tab 5",    hidden = true },
        { "<leader>6",  desc = "Tab 6",    hidden = true },
        { "<leader>7",  desc = "Tab 7",    hidden = true },
        { "<leader>8",  desc = "Tab 8",    hidden = true },
        { "<leader>9",  desc = "Tab 9",    hidden = true },
        { "<leader>0",  desc = "Last Tab", hidden = true },
      })
    end,
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
