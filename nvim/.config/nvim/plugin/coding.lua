vim.pack.add({
  "https://github.com/tpope/vim-surround",
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/andymass/vim-matchup",
  "https://github.com/chrisgrieser/nvim-rulebook",
  "https://github.com/wakatime/vim-wakatime",
  "https://github.com/abecodes/tabout.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/echasnovski/mini.ai",
})

require("ts-comments").setup()

require("nvim-autopairs").setup()

require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
})

require("mini.ai").setup()

require("tabout").setup({
  tabkey = "<Tab>",
  backwards_tabkey = "<S-Tab>",
  act_as_tab = true,
  act_as_shift_tab = false,
  default_tab = "<C-t>",
  default_shift_tab = "<C-d>",
  enable_backwards = true,
  completion = false,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
  },
  ignore_beginning = true,
  exclude = {},
})
