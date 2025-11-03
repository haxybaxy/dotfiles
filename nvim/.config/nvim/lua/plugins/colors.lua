return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = true,
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
