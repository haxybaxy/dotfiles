local picker_config = require("plugins.snacks.picker-config")
local dashboard_config = require("plugins.snacks.dashboard-config")
local highlights = require("plugins.snacks.highlights")
local lazygit_config = require("plugins.snacks.lazygit-config")

return {
  ---@module "snacks"
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    quickfle = { enabled = true },
    explorer = { enabled = true },
    input = { enabled = true },
    image = { enabled = true, doc = { inline = false } },
    statuscolumn = { enabled = true },
    lazygit = lazygit_config.lazygit,
    zen = {
      enabled = true,
      toggles = { dim = false },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = picker_config.picker,
    dashboard = dashboard_config.dashboard,
    styles = {
      zen = {
        backdrop = { transparent = false, blend = 99 },
      },
    },
  },
   config = function(_, opts)
     require("snacks").setup(opts)
     highlights.setup_highlight_autocmd()
     highlights.apply_snacks_highlights()
   end,
  keys = {
    { "<leader><space>", function() Snacks.picker.grep() end, desc = "Ripgrep", },
    { "<leader>f", function() Snacks.picker.files() end, desc = "Find Files", },
    { "<leader>r", function() Snacks.picker.recent() end, desc = "Recent", },
    { "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP Definitions", },
    { "<leader>j", function() Snacks.picker.highlights({pattern = "hl_group:^Snacks"}) end, desc = "Highlight Groups", },
    { "<leader>gr", function() Snacks.picker.lsp_references() end, desc = "LSP References", },
    { "<leader>bf", function() Snacks.picker.buffers() end, desc = "Buffers", },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer", },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History", },
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
  },
}
