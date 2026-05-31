-- obsidian.nvim — notes workflow over the iCloud Obsidian vault.
-- The built-in `ui` handles markdown concealing/rendering (this replaced
-- render-markdown.nvim). Completion is LSP-based and is picked up
-- automatically by blink.cmp's "lsp" source — see completions.lua.

vim.pack.add({ "https://github.com/obsidian-nvim/obsidian.nvim" })

require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "vault16",
			path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault16",
		},
	},
	-- Name new notes by their title, verbatim — matches the vault's existing
	-- "Bounded Context.md" / "Ben Vallack's Todo System.md" style instead of the
	-- default random zettel id. Falls back to a zettel id only when untitled.
	note_id_func = function(title)
		if title ~= nil and title ~= "" then
			return title
		end
		return require("obsidian.builtin").zettel_id()
	end,
	-- New notes (`:Obsidian new`) land in research/
	notes_subdir = "research",
	new_notes_location = "notes_subdir",
	-- Daily notes (`:Obsidian today`/`yesterday`/`dailies`) land in temporal/daily/
	-- date_format matches the existing notes there (e.g. 01-01-2026.md)
	daily_notes = {
		folder = "temporal/daily",
		date_format = "MM-DD-YYYY",
		template = "daily-template.md",
	},
	-- Templates live in meta/ (same folder the Obsidian app/Templater uses).
	-- They're plain frontmatter, so obsidian.nvim inserts them as-is via
	-- `:Obsidian template` and `:Obsidian new_from_template`.
	templates = {
		folder = "meta",
	},
	-- Your notes use minimal, template-defined frontmatter — stop obsidian.nvim
	-- from injecting/rewriting id/aliases when creating or saving notes.
	frontmatter = {
		enabled = false,
	},
	picker = {
		name = "fzf-lua",
	},
	-- Built-in markdown UI (callouts, concealed links, checkboxes, etc.)
	ui = {
		enable = true,
	},
})

-- Vault-wide commands (work from anywhere)
local map = vim.keymap.set
map("n", "<leader>on", "<Cmd>Obsidian new<CR>", { desc = "Obsidian: new note" })
map("n", "<leader>oo", "<Cmd>Obsidian quick_switch<CR>", { desc = "Obsidian: quick switch" })
map("n", "<leader>os", "<Cmd>Obsidian search<CR>", { desc = "Obsidian: search (grep)" })
map("n", "<leader>ot", "<Cmd>Obsidian today<CR>", { desc = "Obsidian: today's daily note" })
map("n", "<leader>oy", "<Cmd>Obsidian yesterday<CR>", { desc = "Obsidian: yesterday's note" })
map("n", "<leader>od", "<Cmd>Obsidian dailies<CR>", { desc = "Obsidian: daily notes" })
map("n", "<leader>og", "<Cmd>Obsidian tags<CR>", { desc = "Obsidian: tags" })
map("n", "<leader>ow", "<Cmd>Obsidian workspace<CR>", { desc = "Obsidian: switch workspace" })
map("n", "<leader>oT", "<Cmd>Obsidian new_from_template<CR>", { desc = "Obsidian: new note from template" })

-- Note-local commands (only meaningful inside a markdown note)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("ObsidianNoteKeys", { clear = true }),
	pattern = "markdown",
	callback = function(args)
		-- obsidian.nvim's UI needs conceal enabled to hide link/markup syntax
		vim.opt_local.conceallevel = 2

		local function opts(desc)
			return { buffer = args.buf, desc = desc }
		end
		map("n", "<leader>ob", "<Cmd>Obsidian backlinks<CR>", opts("Obsidian: backlinks"))
		map("n", "<leader>ol", "<Cmd>Obsidian links<CR>", opts("Obsidian: links in note"))
		map("n", "<leader>oc", "<Cmd>Obsidian toc<CR>", opts("Obsidian: table of contents"))
		map("n", "<leader>or", "<Cmd>Obsidian rename<CR>", opts("Obsidian: rename note"))
		map("n", "<leader>op", "<Cmd>Obsidian paste_img<CR>", opts("Obsidian: paste image"))
		map("n", "<leader>ox", "<Cmd>Obsidian toggle_checkbox<CR>", opts("Obsidian: toggle checkbox"))
		map("n", "<leader>oi", "<Cmd>Obsidian template<CR>", opts("Obsidian: insert template"))
		map("x", "<leader>oe", "<Cmd>Obsidian extract_note<CR>", opts("Obsidian: extract selection to note"))
		map("x", "<leader>ol", "<Cmd>Obsidian link<CR>", opts("Obsidian: link selection"))
	end,
})
