local M = {}

-- Apply custom highlight groups for Snacks components
function M.apply_snacks_highlights()
	local highlights = {
		"SnacksPicker",
		"SnacksPickerPickWin",
		"SnacksPickerPickWinCurrent",
		"SnacksPickerBorder",
		"SnacksPickerTree",
    "SnacksInputNormal",
    "SnacksPickerCol"
	}
	for _, hl_group in ipairs(highlights) do
		vim.api.nvim_set_hl(0, hl_group, { link = "StatusLine" })
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
