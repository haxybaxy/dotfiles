return {
	{ -- manipulate surrounding characters
		"tpope/vim-surround",
	},

	{ -- better commenting with treesitter
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},

	{ -- auto closing brackets
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{ -- auto close html tags
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},

	{ -- better % command and highlight matching tag
		"andymass/vim-matchup",
		opts = {
			treesitter = {
				stopline = 500,
			},
		},
	},

	{ -- highlight todo comments like FIXME, TODO, etc.
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
      config = function ()
        require('nvim-highlight-colors').setup({})
      end
		},
	},

	{
		"brenoprata10/nvim-highlight-colors",
	},

	{ -- render whitespace characters in visual mode
		"mcauley-penney/visual-whitespace.nvim",
		config = true,
		event = "ModeChanged *:[vV\22]",
		opts = {},
	},

	{ -- wakatime integration
		"wakatime/vim-wakatime",
		lazy = false,
	},
}
