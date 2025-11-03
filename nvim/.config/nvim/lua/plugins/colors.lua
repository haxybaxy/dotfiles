return
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        vim.cmd("colorscheme tokyonight-night"),
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#16161E", bg = "#16161E" }),
      })
    end,
  }
