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
    vim.cmd("colorscheme onedark")
    end,
  },
}
