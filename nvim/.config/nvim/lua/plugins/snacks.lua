return {
  ---@module "snacks"
  "folke/snacks.nvim",
  lazy = false,
  priority = 500,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    quickfle = { enabled = true },
    image = { enabled = true, doc = { inline = false } },
    statuscolumn = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    explorer = { enabled = true, replace_netrw = true },
    picker = { sources = { explorer = { layout = { layout = { position = "right" } } } } },
    lazygit = {
      theme = {
        searchingActiveBorderColor = { fg = "Visual", bold = true },
        selectedLineBgColor = { bg = "Visual" },
        inactiveBorderColor = { fg = "SnacksPickerUnselected" },
      },
      win = {
        wo = {
          winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal",
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>bn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle
            .new({
              id = "git_signs",
              name = " Git Sign Column",
              get = function()
                return require("gitsigns.config").config.signcolumn
              end,
              set = function(state)
                require("gitsigns").toggle_signs(state)
              end,
            })
            :map("<leader>ug")
      end,
    })
  end,
}
