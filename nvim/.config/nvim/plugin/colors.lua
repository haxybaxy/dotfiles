vim.pack.add({ { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" } })
vim.pack.add({ { src = "https://github.com/folke/tokyonight.nvim.git" } })

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

vim.cmd.colorscheme("tokyonight-storm")
vim.opt.fillchars:append({ eob = " " })
