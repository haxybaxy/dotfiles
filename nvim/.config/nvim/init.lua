vim.cmd("set number")  --show current line number
vim.cmd("set relativenumber") -- relative numbers for the rest
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- colors

	{
    		'nvim-telescope/telescope.nvim', tag = '0.1.8', -- live grep
     		dependencies = { 'nvim-lua/plenary.nvim' },
	},

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



local opts = {}

require("lazy").setup(plugins, opts) -- lazy setup

require("catppuccin").setup() -- colorscheme setup
vim.cmd.colorscheme "catppuccin"

local builtin = require('telescope.builtin') -- telescope keybinds 
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

local config = require("nvim-treesitter.configs") -- treesitter setup
config.setup({  
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "json", "python", "javascript", "html", "css" },
	highlight = { enable = true },
        indent = { enable = true },
})

vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal right<CR>') -- neotree keybind
