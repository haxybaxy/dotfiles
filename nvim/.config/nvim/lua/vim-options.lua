vim.g.mapleader = " " -- Set leader key to space

vim.cmd("set number") -- Show line numbers
vim.cmd("set relativenumber") -- relative numbers for the rest

vim.cmd("set expandtab") -- spaces instead of tabs
vim.cmd("set tabstop=2") -- 2 spaces for a tab
vim.cmd("set softtabstop=2") -- 2 spaces for soft tab
vim.cmd("set shiftwidth=2") -- 2 spaces for autoindent

vim.opt.winborder = "rounded" -- Set window border style to rounded

vim.o.undofile = true -- Enable persistent undo

vim.o.wrap = false -- Disable line wrapping

vim.o.showmode = false -- Don't show mode since we have a statusline

vim.o.cursorline = true -- Highlight the current line

vim.o.showbreak="↪" -- Show a special character for wrapped lines

vim.opt.termguicolors = true -- Enable true color support

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

-- tab new and tabclose keybinds
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { silent = true })

-- neovide gui settings with macOS keybinds
if vim.g.neovide then
  vim.defer_fn(function()
    vim.cmd("NeovideFocus")
  end, 25)
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

