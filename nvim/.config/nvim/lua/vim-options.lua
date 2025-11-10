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

vim.o.cursorline = true -- highlight current line

vim.o.scrolloff = 4 -- start scrolling 4 lines from bottom

vim.opt.fillchars:append({ eob = " " }) -- Show a blank space for end of buffer

vim.opt.termguicolors = true -- Enable true color support

vim.o.showmode = false -- Don't show mode since we have a statusline

vim.o.splitright = true -- vsplit to the right

-- Allow recursive globbing (**)
vim.opt.path:append("**")

-- Ignore common junk directories when searching
vim.opt.wildignore:append({
	"*/.git/*",
	"*/node_modules/*",
	"*/dist/*",
	"*/build/*",
	"*/venv/*",
	"*/__pycache__/*",
	"*.egg-info/*",
	"*/.next/*",
	"*/ios/*",
	"*/android/*",
	"*/.expo/*",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- nicer diagnostic indicators
vim.diagnostic.config({
	signs = {
		-- define text icons per severity
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.HINT] = "●",
			[vim.diagnostic.severity.INFO] = "●",
		},
	},
	underline = true,
	update_in_insert = false,
})

-- hide all separators
vim.opt.fillchars = {
	vert = " ", -- vertical separator
	vertleft = " ", -- for left separators
	vertright = " ", -- for right separators
	horiz = " ", -- horizontal separator
	horizup = " ", -- for top separators
	horizdown = " ", -- for bottom separators
	eob = " ", -- hide end-of-buffer tildes
}
--Keybinds should go under here
--Tab keybinds
vim.keymap.set("n", "<leader>tn", "<Cmd>tabnew<CR>", { silent = true, desc = "New Tab" })
vim.keymap.set("n", "<leader>tx", "<Cmd>tabclose<CR>", { silent = true, desc = "Close Tab" })

for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>", { desc = "Go to tab " .. i })
end
vim.keymap.set("n", "<leader>0", "<Cmd>tablast<CR>", { desc = "Go to last tab" })

--Copy and pasting
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>p",
	'"+p',
	{ noremap = true, silent = true, desc = "Paste from system clipboard" }
)

-- Remove search highlights
vim.keymap.set({ "n", "v", "x" }, "<leader>h", "<Cmd>noh<CR>", { desc = "Disable highlight for last search" })

-- QOL quick exit and Save
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { silent = true, desc = "Save" })
vim.keymap.set("n", "<leader>q", "<Cmd>wq<CR>", { silent = true, desc = "Save and quit" })

-- autocmds go under here
-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break -- Found a supporting client, no need to check others
				end
			end

			--Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
	group = "LspReferenceHighlight",
	desc = "Clear highlights when entering insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- colorscheme set
-- Set initial colorscheme after all plugins are fully loaded
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.defer_fn(function()
			if vim.o.background == "light" then
				vim.cmd.colorscheme("dawnfox")
			else
				vim.cmd.colorscheme("gruvbox-material")
			end
		end, 1)
	end,
	once = true,
})
