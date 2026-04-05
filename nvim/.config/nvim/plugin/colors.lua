vim.pack.add({ { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" } })

require("evergarden").setup({
	theme = {
		variant = "spring", -- 'winter'|'fall'|'spring'|'summer'
		accent = "aqua",
	},
	editor = {
		transparent_background = false,
		sign = { color = "none" },
		float = {
			color = "mantle",
			solid_border = false,
		},
		completion = {
			color = "surface0",
		},
	},
})

vim.cmd.colorscheme("evergarden")
vim.opt.fillchars:append({ eob = " " })
