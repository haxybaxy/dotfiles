vim.cmd("set number")  --show current line number
vim.cmd("set relativenumber") -- relative numbers for the rest

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

--vim.opt.clipboard = 'unnamedplus'

vim.o.undofile = true



vim.g.mapleader = " "


if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- Disable arrow keys
-- vim.api.nvim_set_keymap('n','<Up>','<Nop>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n','<Down>','<Nop>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n','<Left>','<Nop>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n','<Right>','<Nop>', { noremap = true, silent = true})
-- 
-- 
-- vim.api.nvim_set_keymap('i','<Up>','<Nop>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i','<Down>','<Nop>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i','<Left>','<Nop>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i','<Right>','<Nop>', { noremap = true, silent = true})

-- Yank to system clipboard in normal mode with <leader>y
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true })

-- Yank to system clipboard in visual mode with <leader>y
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })

