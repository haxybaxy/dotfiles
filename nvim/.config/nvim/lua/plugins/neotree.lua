return {
	"nvim-neo-tree/neo-tree.nvim", -- file tree
  	branch = "v3.x",
  	dependencies = {
    		"nvim-lua/plenary.nvim",
    		"nvim-tree/nvim-web-devicons",
    		"MunifTanjim/nui.nvim",
  			},
	config = function()
		vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal right<CR>', {}) -- neotree keybind
require('neo-tree').setup {
  filesystem = {
    filtered_items = {
      visible = true,
    }}}
	end
}
