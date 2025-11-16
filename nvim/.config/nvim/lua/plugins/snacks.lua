local picker_config = require("plugins.snacks.picker-config")
local dashboard_config = require("plugins.snacks.dashboard-config")
local lazygit_config = require("plugins.snacks.lazygit-config")
local input_config = require("plugins.snacks.input-config")
local zen_config = require("plugins.snacks.zen-config")
local highlights = require("plugins.snacks.highlights")

return {
  ---@module "snacks"
  "folke/snacks.nvim",
  lazy = false,
  priority = 500,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    quickfle = { enabled = true },
    explorer = { enabled = true },
    image = { enabled = true, doc = { inline = false } },
    statuscolumn = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    input = input_config.input,
    lazygit = lazygit_config.lazygit,
    picker = picker_config.picker,
    dashboard = dashboard_config.dashboard,
    zen = zen_config.zen,
  },
  keys = {
    {
      "<leader><space>",
      function()
        Snacks.picker.grep()
      end,
      desc = "Ripgrep",
    },
    {
      "<leader>f",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>r",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "LSP Definitions",
    },
    -- {
    -- 	"<leader>j",
    -- 	function()
    -- 		Snacks.picker.highlights({ pattern = "hl_group:^Snacks" })
    -- 	end,
    -- 	desc = "Highlight Groups",
    -- },
    {
      "<leader>gr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "LSP References",
    },
    {
      "<leader>bf",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
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
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
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
              name = " Git Sign Column",
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
    highlights.setup_highlight_autocmd()
    highlights.apply_snacks_highlights()
  end,
}
