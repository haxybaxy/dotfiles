local M = {}

function M.get_window_relative_flow_config()
  local win = vim.api.nvim_get_current_win()
  local win_config = vim.api.nvim_win_get_config(win)
  local win_pos = vim.api.nvim_win_get_position(win)
  local win_width = vim.api.nvim_win_get_width(win)
  local win_height = vim.api.nvim_win_get_height(win)

  -- Get editor dimensions
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  -- Calculate window position in editor coordinates
  local win_col = win_pos[2]
  local win_row = win_pos[1]

  -- If it's a floating window, use its absolute position
  if win_config.relative and win_config.relative ~= "" then
    win_col = win_config.col or win_col
    win_row = win_config.row or win_row
  end

  -- Calculate picker dimensions relative to current window
  local picker_width = math.min(win_width - 4, math.floor(editor_width * 0.4)) -- Use window width but cap it
  local picker_height = math.floor(win_height * 0.3)                          -- 30% of window height for bottom third

  -- Position picker centered horizontally within the current window, in the bottom third
  local target_col = win_col + math.floor((win_width - picker_width) / 2)
  local target_row = win_row + math.floor(win_height * 0.67) -- Start at 67% down the window

  -- Ensure picker doesn't go off screen
  if target_col < 0 then
    target_col = 0
  end
  if target_col + picker_width > editor_width then
    target_col = editor_width - picker_width
  end
  if target_row < 0 then
    target_row = 0
  end
  if target_row + picker_height > editor_height then
    target_row = editor_height - picker_height
  end

  -- Return the proper layout structure that Snacks expects
  return {
    preview = "main",
    layout = {
      backdrop = false,
      col = target_col,
      width = picker_width,
      min_width = 50,
      row = target_row,
      height = picker_height,
      min_height = 10,
      box = "vertical",
      border = "solid",
      title = "{title} {live} {flags}",
      title_pos = "center",
      wo = {
        winhighlight =
        "Normal:Pmenu,NormalNC:Statusline,WinBar:Pmenu,WinBarNC:Pmenu,FloatTitle:Pmenu,FloatFooter:Pmenu,WinSeparator:Pmenu",
      },
      { win = "preview", title = "{preview}", width = 0.6, border = "left" },
      {
        win = "input",
        height = 1,
        border = "solid",
        wo = {
          winhighlight = "NormalFloat:Pmenu,FloatBorder:Pmenu,FloatTitle:Pmenu",
        },
      },
      { win = "list", border = "none" },
    },
  }
end

return M
