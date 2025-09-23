return {
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        cmdline_popup = {
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
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
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
}
