vim.pack.add({ { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" } })
vim.pack.add({ { src = "https://github.com/folke/tokyonight.nvim.git" } })
vim.pack.add({ { src = "https://github.com/maxmx03/solarized.nvim.git" } })
vim.pack.add({ { src = "https://github.com/navarasu/onedark.nvim.git" } })
vim.pack.add({ { src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" } })
vim.pack.add({ { src = "https://github.com/f-person/auto-dark-mode.nvim.git" } })

require("evergarden").setup({
	theme = {
		variant = "spring", -- 'winter'|'fall'|'spring'|'summer'
		accent = "aqua",
	},
	editor = {
		transparent_background = false,
		sign = { color = "none" },
		cursor = { color = "accent" },
		float = {
			color = "mantle",
			solid_border = false,
		},
		completion = {
			color = "surface0",
			selected = {
				color = "surface2",
				style = { "bold" },
			},
		},
	},
})

require("tokyonight").setup({})

require("onedark").setup({
	style = "dark",
})

require("catppuccin").setup({
	flavour = "auto",
	background = { light = "latte", dark = "mocha" },
})
vim.cmd.colorscheme("catppuccin")

require("auto-dark-mode").setup({
	update_interval = 3000,
	set_dark_mode = function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
	set_light_mode = function()
		vim.o.background = "light"
		vim.cmd.colorscheme("catppuccin-latte")
	end,
})

vim.opt.fillchars:append({ eob = " " })
