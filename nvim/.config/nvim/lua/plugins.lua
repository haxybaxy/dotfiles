return {

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- syntax highlighting
	
	{
		"nvim-neo-tree/neo-tree.nvim", -- file tree
  		branch = "v3.x",
  		dependencies = {
    			"nvim-lua/plenary.nvim",
    			"nvim-tree/nvim-web-devicons",
    			"MunifTanjim/nui.nvim",
  			}
	},


    }


