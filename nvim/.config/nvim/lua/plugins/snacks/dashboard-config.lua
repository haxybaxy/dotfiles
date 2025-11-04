local M = {}

M.dashboard = {
  enabled = true,
  sections = {
    {
      section = "terminal",
      cmd = [[bash -c 'a=$(curl -s https://www.affirmations.dev/ | jq -r ".affirmation"); printf "%*s\n" $(( (${COLUMNS:-$(tput cols)} + ${#a})/2 )) "$a"']],
      hl = "header",
      height = 4,
      align = "center",
    },
    { icon = "", title = "Keymaps", section = "keys" },
    { section = "startup" },
  },
}

return M
