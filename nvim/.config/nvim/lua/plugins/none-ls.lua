return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jay-babu/mason-null-ls.nvim",
  },

  config = function()
    local null_ls = require("null-ls")
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua",
        "prettier",
        "ruff",
      },
      automatic_installation = true,
    })

    null_ls.setup({
      sources = {
        require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
        require("none-ls.formatting.ruff_format"),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
        null_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint"),
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
