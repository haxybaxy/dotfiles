return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = false,
      },
      sections = {
        lualine_b = { "diagnostics" },
        lualine_x = {
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
          },
        },
        lualine_y = { "branch" },
        lualine_z = { "progress" },
      },
    })
  end,
}
