local M = {}

M.dashboard = {
  enabled = true,
  sections = {
    {
      section = "terminal",
      cmd = "curl -s https://www.affirmations.dev/ | jq -r '.affirmation'",
      hl = "header",
      height = 4,
      align = "center",
    },
    { icon = "", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
    { icon = "", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    { icon = "", title = "Projects", section = "projects", indent = 2, padding = 1 },
    { section = "startup" },
  },
}

return M
