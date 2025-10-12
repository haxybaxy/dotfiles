return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
      })
    end,
  },
  { -- light mode
    "catppuccin/nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("catppuccin").setup({
        float = {
          transparent = false,
          solid = false,
        },
      })
    end,
  },
}
