return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			float = {
				transparent = false,-- enable transparent floating windows
				solid = true, -- use solid styling for floating windows, see |winborder|
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
