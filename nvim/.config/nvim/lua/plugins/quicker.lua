return {
  "stevearc/quicker.nvim",
  ft = "qf",
  config = function()
    require("quicker").setup({
      vim.keymap.set("n", "<leader>q", function()
        require("quicker").toggle()
      end, {
        desc = "Toggle quickfix",
      }),
      vim.keymap.set("n", "<leader>l", function()
        require("quicker").toggle({ loclist = true })
      end, {
        desc = "Toggle loclist",
      }),
      require("quicker").setup({
        keys = {
          {
            ">",
            function()
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      }),
    })
  end,
}
