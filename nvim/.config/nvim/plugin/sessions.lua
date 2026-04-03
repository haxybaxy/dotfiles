vim.pack.add({ "https://github.com/rmagatti/auto-session" })

require("auto-session").setup({
  suppressed_dirs = { "~/", "~/Downloads", "/" },
  close_filetypes_on_save = { "neo-tree" },
})
