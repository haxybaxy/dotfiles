return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        float = {
          transparent = false,
          solid = false,
        },
        integrations = {
          snacks = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
