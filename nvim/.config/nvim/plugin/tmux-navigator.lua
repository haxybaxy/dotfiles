vim.pack.add({ "https://github.com/baggiponte/rex-navigator.nvim" })
require("rex-navigator").setup()
if vim.env.TMUX ~= nil and vim.env.TMUX ~= "" then
	vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })
end
