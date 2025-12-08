local M = {}

-- Define highlight mappings here
M.highlight_map = {
	SnacksPicker = "Pmenu",
	SnacksPickerListCursorLine = "PmenuSel",
	SnacksPickerInputCursorLine = "PmenuSel",
	SnacksPickerBoxCursorLine = "PmenuSel",
	SnacksPickerPreviewCursorLine = "PmenuSel",
	SnacksPickerPickWin = "Pmenu",
	SnacksPickerPickWinCurrent = "Pmenu",
	SnacksPickerBorder = "Pmenu",
	SnacksPickerTree = "SnacksPickerUnselected",
	SnacksPickerCol = "Pmenu",
	SnacksPickerPrompt = "Pmenu",
	SnacksInputTitle = "SnacksPickerList",
}

-- Apply custom highlight groups for Snacks components
function M.apply_highlights()
	for hl_group, link_target in pairs(M.highlight_map) do
		vim.api.nvim_set_hl(0, hl_group, { link = link_target })
	end

	vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true })
	vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true })
	vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true })
end

-- Set up autocommand to apply highlights after colorscheme changes
function M.setup_highlight_autocmd()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("SnacksHighlights", { clear = true }),
		callback = M.apply_highlights,
	})
end

return M
