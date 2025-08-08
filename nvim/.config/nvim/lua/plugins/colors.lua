return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 999,
    config = function()
      require("onedark").setup({
        transparent = true,
        ending_tildes = true,
      })
    end
	},

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
		config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          darken = {
            sidebars = {
              enable = false,
            },
          },
        }
      })
			vim.cmd("colorscheme github_dark_default")
		end,
	},

	{
		"f-person/auto-dark-mode.nvim",
		config = function()
			require("auto-dark-mode").setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.o.background = "dark"
					vim.cmd("colorscheme github_dark_default")
				end,
				set_light_mode = function()
					vim.o.background = "light"
					vim.cmd("colorscheme onedark")
				end,
			})
		end,
	},

}
