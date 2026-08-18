-- render-markdown.nvim — in-buffer rendering for markdown (headings, code blocks,
-- bullets, checkboxes, callouts, tables). Uses the markdown/markdown_inline
-- treesitter parsers (installed in treesitter.lua) and mini.icons for code
-- language icons (set up in oil.lua).
-- obsidian.nvim's own `ui` stays disabled so the two don't render the same
-- elements twice — see obsidian.lua.

vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

require("render-markdown").setup({
	-- Rendered in normal/command/terminal modes only (plugin default), so insert
	-- mode drops back to raw markup while editing.
	render_modes = { "n", "c", "t" },
	-- Cursor line always shows raw markup so you can edit what's under the cursor.
	anti_conceal = { enabled = true },
	-- LaTeX rendering shells out to `latex2text` (pylatexenc), which isn't
	-- installed — leave equations as plain text instead.
	latex = { enabled = false },
	-- Callout/checkbox completions through the in-process LSP; blink.cmp already
	-- has "lsp" in its sources — see completions.lua.
	completions = { lsp = { enabled = true } },
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("RenderMarkdownKeys", { clear = true }),
	pattern = "markdown",
	callback = function(args)
		vim.keymap.set("n", "<leader>mr", "<Cmd>RenderMarkdown toggle<CR>", {
			buffer = args.buf,
			desc = "Render Markdown Toggle",
		})
	end,
})
