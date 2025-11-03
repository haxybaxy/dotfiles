vim.g.mapleader = " " -- Set leader key to space

vim.cmd("set number") -- Show line numbers
vim.cmd("set relativenumber") -- relative numbers for the rest

vim.cmd("set expandtab") -- spaces instead of tabs
vim.cmd("set tabstop=2") -- 2 spaces for a tab
vim.cmd("set softtabstop=2") -- 2 spaces for soft tab
vim.cmd("set shiftwidth=2") -- 2 spaces for autoindent

vim.o.undofile = true -- Enable persistent undo

vim.o.wrap = false -- Disable line wrapping

vim.o.showbreak = "↪" -- Show a special character for wrapped lines

vim.o.scrolloff = 4 -- start scrolling 4 lines from bottom

vim.opt.fillchars:append({ eob = " " }) -- Show a blank space for end of buffer

vim.opt.termguicolors = true -- Enable true color support

vim.o.showmode = false -- Don't show mode since we have a statusline

vim.o.splitright = true -- always split windows to the right

-- Allow recursive globbing (**)
vim.opt.path:append("**")

-- Ignore common junk directories when searching
vim.opt.wildignore:append { "*/.git/*", "*/node_modules/*", "*/dist/*", "*/build/*", "*/venv/*", "*/__pycache__/*", "*.egg-info/*", "*/.next/*", "*/ios/*", "*/android/*", "*/.expo/*"}

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- nicer diagnostic indicators
local signs = {
  Error = "●",
  Warn = "●",
  Hint = "●",
  Info = "●"
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

--Keybinds should go under here
--Tab keybinds
vim.keymap.set("n", "<leader>tn", "<Cmd>tabnew<CR>", { silent = true, desc = "New Tab"})
vim.keymap.set("n", "<leader>tx", "<Cmd>tabclose<CR>", { silent = true, desc = "Close Tab" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>", { desc = "Go to tab " .. i })
end
vim.keymap.set("n", "<leader>0", "<Cmd>tablast<CR>", { desc = "Go to last tab" })

--Copy and pasting
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', {desc = "Yank to system clipboard"})
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })

-- Remove search highlights
vim.keymap.set({ "n", "v", "x" }, "<leader>h", '<Cmd>noh<CR>', {desc = "Disable highlight for last search"})

-- QOL quick exit and Save
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { silent = true, desc = "Save" })
vim.keymap.set("n", "<leader>q", "<Cmd>wq<CR>", { silent = true, desc = "Save and quit" })


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
