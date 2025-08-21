return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("onedark").setup({
        transparent = true,
        ending_tildes = true,
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "wave",
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
