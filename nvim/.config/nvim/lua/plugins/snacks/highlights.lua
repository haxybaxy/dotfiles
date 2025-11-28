local M = {}

-- Define highlight mappings here
M.highlight_map = {
	SnacksPicker = "StatusLine",
	SnacksPickerPickWin = "StatusLine",
	SnacksPickerPickWinCurrent = "StatusLine",
	SnacksPickerBorder = "StatusLine",
	SnacksPickerTree = "SnacksPickerUnselected",
	SnacksInputNormal = "StatusLine",
	SnacksPickerCol = "StatusLine",
	SnacksPickerPrompt = "StatusLine",
	SnacksInputTitle = "SnacksPickerList",
	Visual = "IncSearch",
}

-- Apply custom highlight groups for Snacks components
function M.apply_snacks_highlights()
	for hl_group, link_target in pairs(M.highlight_map) do
		vim.api.nvim_set_hl(0, hl_group, { link = link_target })
	end
end

-- Set up autocommand to apply highlights after colorscheme changes
function M.setup_highlight_autocmd()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("SnacksHighlights", { clear = true }),
		callback = M.apply_snacks_highlights,
	})
end

return M
