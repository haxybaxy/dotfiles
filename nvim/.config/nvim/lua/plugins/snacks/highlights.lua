local M = {}

---------------------------------------------------------------------
-- Highlight group definitions
---------------------------------------------------------------------

-- Simple link targets
M.link_map = {
  -- Snacks
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

-- Style groups (not links)
M.style_map = {
  -- LSP refs
  LspReferenceText = { underline = true },
  LspReferenceRead = { underline = true },
  LspReferenceWrite = { underline = true },

  -----------------------------------------------------------------
  -- Universal keyword styles
  -----------------------------------------------------------------
  Keyword = { bold = true },
  Conditional = { bold = true },
  Repeat = { bold = true },
  Label = { bold = true },
  Operator = { bold = true },
  ["@keyword"] = { bold = true },
  ["@keyword.return"] = { bold = true },
  ["@keyword.operator"] = { bold = true },
  ["@keyword.function"] = { bold = true },
  ["@conditional"] = { bold = true },
  ["@repeat"] = { bold = true },
  ["@operator"] = { bold = true },

  -----------------------------------------------------------------
  -- Universal type styles
  -----------------------------------------------------------------
  Type = { bold = true },
  StorageClass = { bold = true },
  Structure = { bold = true },
  Typedef = { bold = true },
  ["@type"] = { bold = true },
  ["@type.builtin"] = { bold = true },
  ["@type.definition"] = { bold = true },
  ["@type.qualifier"] = { bold = true },
}

---------------------------------------------------------------------
-- Apply highlights
---------------------------------------------------------------------
function M.apply_highlights()
  local set = vim.api.nvim_set_hl

  -- Apply linked groups
  for group, link_target in pairs(M.link_map) do
    set(0, group, { link = link_target })
  end

  -- Apply style groups
  for group, opts in pairs(M.style_map) do
    set(0, group, opts)
  end
end

---------------------------------------------------------------------
-- Autocmd hook
---------------------------------------------------------------------
function M.setup_highlight_autocmd()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("SnacksHighlights", { clear = true }),
    callback = M.apply_highlights,
  })
end

return M
