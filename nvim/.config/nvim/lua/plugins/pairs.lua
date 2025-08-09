return {
  { -- auto closing brackets
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  { -- auto close html tags
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },
  { -- better % command and highlight matchign tag
    'andymass/vim-matchup',
    opts = {
      treesitter = {
        stopline = 500,
      }
    }
  }
}
