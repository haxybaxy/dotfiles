vim.pack.add({ "https://github.com/rmagatti/auto-session" })

require("auto-session").setup({
  suppressed_dirs = { "~/", "~/Downloads", "/" },
})
