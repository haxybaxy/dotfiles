vim.g.mapleader = " " -- Set leader key to space

vim.cmd("set relativenumber") -- relative numbers for the rest

vim.cmd("set expandtab") -- spaces instead of tabs
vim.cmd("set tabstop=2") -- 2 spaces for a tab
vim.cmd("set softtabstop=2") -- 2 spaces for soft tab
vim.cmd("set shiftwidth=2") -- 2 spaces for autoindent

vim.o.undofile = true -- Enable persistent undo

vim.o.wrap = false -- Disable line wrapping

-- Yank to system clipboard in normal and visual mode with <leader>y
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')

-- Paste from system clipboard in normal mode and visual mode with <leader>p
vim.keymap.set({ 'n', 'v', 'x' }, "<leader>p", '"+p', { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- neovide gui settings with macOS keybinds
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end


