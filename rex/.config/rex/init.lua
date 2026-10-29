-- ~/.config/rex/init.lua
-- Reload with `rex config reload`; check with `rex config check`.
-- Ctrl+Space is the prefix, as in tmux. The pickers need Remote Control on in
-- Rex → Settings → Rex Server, so their floating terminals can ask the app to
-- switch sessions.

-- Project picker: https://github.com/haxybaxy/rex-sessionizer
require("rex-sessionizer").setup({ work_dir = "~/work" })
rex.bind("ctrl+space>f", "sessionizer")

-- Worktree pickers via worktrunk: https://github.com/haxybaxy/rex-worktrunk
require("rex-worktrunk").setup({ base = "@" })
rex.bind("ctrl+space>g", "worktree")
rex.bind("ctrl+space>d", "worktree_remove")

-- Ctrl+Space starts a key sequence, so press it twice to send one to the
-- terminal, the same trick tmux users use for the prefix key.
rex.bind("ctrl+space>ctrl+space", "pane.send_key", { key = "ctrl+space" })

local data = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
local plugin = data .. "/nvim/site/pack/core/opt/rex-navigator.nvim"
local ok, err = pcall(function()
	dofile(plugin .. "/rex/navigator.lua").setup({ wrap = false })
end)
if not ok then
	rex.log("warn", "rex-navigator not loaded: " .. tostring(err))
end
