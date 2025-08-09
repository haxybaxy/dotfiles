return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    quickfle = { enabled = true },
    explorer = { enabled = true },
    terminal = { enabled = true },
    dashboard = { enabled = true },
    image = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      ui_select = true,
      sources = {
        files = { hidden = true },
        explorer = {
          include = { ".*", "hidden" },
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },

    styles = {
      lazygit = {
        height = 0.9,
        width = 0.9,
        backdrop = 100,
      },
    },
  },

  keys = {
    { "<leader><space>", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer", },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History", },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },

    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
        end,
      })
    end,
  },
}
