vim.pack.add({
	{ src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0" },
})

-- Im switching up on you the moment 0.13 comes out
local mc = require("multicursor-nvim")
mc.setup()

local set = vim.keymap.set

-- Add or skip cursor above/below the main cursor.
set({ "n", "x" }, "<up>", function()
	mc.lineAddCursor(-1)
end, { desc = "Add cursor above" })
set({ "n", "x" }, "<down>", function()
	mc.lineAddCursor(1)
end, { desc = "Add cursor below" })
set({ "n", "x" }, "<leader><up>", function()
	mc.lineSkipCursor(-1)
end, { desc = "Skip cursor above" })
set({ "n", "x" }, "<leader><down>", function()
	mc.lineSkipCursor(1)
end, { desc = "Skip cursor below" })

-- Add or skip adding a new cursor by matching word/selection
set({ "n", "x" }, "<M-d>", function()
	mc.matchAddCursor(1)
end, { desc = "Add cursor at next match" })
set({ "n", "x" }, "<D-d>", function()
	mc.matchAddCursor(1)
end, { desc = "Add cursor at next match" })
set({ "n", "x" }, "<leader>s", function()
	mc.matchSkipCursor(1)
end, { desc = "Skip to next match" })
set({ "n", "x" }, "<leader>N", function()
	mc.matchAddCursor(-1)
end, { desc = "Add cursor at previous match" })
set({ "n", "x" }, "<leader>S", function()
	mc.matchSkipCursor(-1)
end, { desc = "Skip to previous match" })

-- Add and remove cursors with control + left click.
set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Toggle cursor at click" })
set("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "Add cursors by dragging" })
set("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "Finish cursor drag" })

-- Disable and enable cursors.
set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle cursor" })

-- Mappings defined in a keymap layer only apply when there are
-- multiple cursors. This lets you have overlapping mappings.
mc.addKeymapLayer(function(layerSet)
	-- Select a different cursor as the main one.
	layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Previous cursor" })
	layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Next cursor" })

	-- Delete the main cursor.
	layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete cursor" })

	-- Enable and clear cursors using escape.
	layerSet("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		else
			mc.clearCursors()
		end
	end, { desc = "Enable or clear cursors" })
end)

-- Customize how cursors look.
local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
