return {
  {
    "uhs-robert/oasis.nvim",
    lazy = false,
    priority = 1000,
  --   config = function()
  --     require("oasis").setup({
  --       dark_style = "night", -- Optional: Choose any style like `lagoon` or 'dune'.
  --       light_style = "dawn"
  --     })
  --   end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day"
      })
      vim.cmd("colorscheme tokyonight")
    end,
  }
}
