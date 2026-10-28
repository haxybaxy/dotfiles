vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
vim.pack.add({ { src = "https://github.com/EdenEast/nightfox.nvim" } })
vim.pack.add({ { src = "https://github.com/webhooked/kanso.nvim" } })
vim.pack.add({ { src = "https://github.com/oxfist/night-owl.nvim" } })
vim.pack.add({ { src = "https://github.com/f-person/auto-dark-mode.nvim" } })

require("catppuccin").setup({
	flavour = "auto",
	background = { light = "latte", dark = "mocha" },
})

require("kanso").setup({})

require("auto-dark-mode").setup({
	update_interval = 3000,
	set_dark_mode = function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("catppuccin")
	end,
	set_light_mode = function()
		vim.o.background = "light"
		vim.cmd.colorscheme("catppuccin-latte")
	end,
})
