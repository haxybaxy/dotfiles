return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

    local custom_catppuccin = {
      normal = {
        a = { bg = "None", fg = colors.text, gui = "bold" },
        b = { bg = "None", fg = colors.text },
        c = { bg = "None", fg = colors.text },
      },
      insert = {
        a = { bg = "None", fg = colors.blue, gui = "bold" },
        b = { bg = "None", fg = colors.text },
        c = { bg = "None", fg = colors.text },
      },
      visual = {
        a = { bg = "None", fg = colors.yellow, gui = "bold" },
        b = { bg = "None", fg = colors.text },
        c = { bg = "None", fg = colors.text },
      },
      replace = {
        a = { bg = "None", fg = colors.red, gui = "bold" },
        b = { bg = "None", fg = colors.text },
        c = { bg = "None", fg = colors.text },
      },
      command = {
        a = { bg = "None", fg = colors.green, gui = "bold" },
        b = { bg = "None", fg = colors.text },
        c = { bg = "None", fg = colors.text },
      },
      terminal = {
        a = { bg = "None", fg = colors.teal, gui = "bold" },
        b = { bg = "None", fg = colors.text },
        c = { bg = "None", fg = colors.text },
      },
      inactive = {
        a = { bg = "None", fg = colors.overlay1, gui = "bold" },
        b = { bg = "None", fg = colors.overlay1 },
        c = { bg = "None", fg = colors.overlay1 },
      },
    }

    require("lualine").setup({
      options = {
        theme = custom_catppuccin,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
