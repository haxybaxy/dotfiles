return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        float = {
          transparent = true,
          solid = true,
        },
        integrations = {
          snacks = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
      vim.cmd(":hi statusline guibg=NONE")
    end,
  },
}
