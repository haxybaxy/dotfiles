return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 999,
    config = function()
    vim.cmd("colorscheme catppuccin")
    end,
  },
}
