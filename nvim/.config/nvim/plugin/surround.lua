-- nvim-surround + which-key hints, in one place.
--
-- The which-key integration is vendored from
-- https://github.com/gregorias/nvim-surround-wk (MIT) and inlined as a single
-- self-contained file instead of a managed plugin. It pops up a which-key menu
-- listing the available surrounds (with their labels) whenever nvim-surround
-- asks for a surround character, by monkey-patching nvim-surround.input.get_char
-- and registering a small which-key "plugin".
--
-- which-key itself is set up in plugin/vfx.lua.

-- Install and configure nvim-surround.
vim.pack.add({ "https://github.com/kylechui/nvim-surround" })
require("nvim-surround").setup()

-- ─── which-key integration ───────────────────────────────────────────────────

-- Shared state (was wk-plugin-state.lua in the original).
-- "⌨S" is a key sequence chosen so it never collides with a real keymap.
local plugin_keys = "⌨S"
local state = {
	selected_key = nil,
	---@type table<string, string>
	expand_hints = {},
}

-- The which-key plugin definition (was wk-plugin.lua). which-key calls expand()
-- to render the dynamic list of surrounds each time the menu is shown.
---@type wk.Plugin
local wk_plugin = {
	name = "nvim-surround",
	expand = function()
		---@type wk.Plugin.item[]
		local items = {}
		for key, label in pairs(state.expand_hints) do
			table.insert(items, {
				key = key,
				desc = label,
				value = "",
				action = function()
					state.selected_key = key
				end,
			})
		end
		table.sort(items, function(a, b)
			return a.key < b.key
		end)
		return items
	end,
	setup = function() end,
}

---Show a which-key menu with the given hints and return the user's pick.
---@param hints table<string, string> Map from chars to their labels.
---@param mode "n"|"x"
---@return string? selected_key
local function pick(hints, mode)
	state.selected_key = nil
	state.expand_hints = hints
	require("which-key").show({ keys = plugin_keys, mode = mode })
	return state.selected_key
end

---Build the hints table from nvim-surround's surrounds and aliases.
---@param surrounds table<string, table>
---@param aliases table<string, string|string[]>
---@return table<string, string> hints
local function get_hints(surrounds, aliases)
	local hints = {}
	for char, surround in pairs(surrounds) do
		-- Keep single chars only; this throws away "invalid_key_behavior".
		if string.len(char) == 1 then
			hints[char] = surround.label or char
		end
	end
	for char, alias in pairs(aliases) do
		hints[char] = type(alias) == "table" and table.concat(alias, ",") or alias
	end
	return hints
end

-- Replacement for nvim-surround.input.get_char: ask the user via which-key.
---@return string|nil @The chosen character, or nil if <Esc> is pressed.
local function get_char()
	local config = require("nvim-surround.config")
	return pick(get_hints(config.get_opts().surrounds, config.get_opts().aliases), "n")
end

-- Register the which-key plugin and hook nvim-surround's char input.
local function attach()
	local wk = require("which-key")
	-- Register a mapping at our reserved keys whose rendering is delegated to
	-- the plugin via the `plugin` field (which-key calls wk_plugin.expand()).
	wk.add({
		{
			[1] = plugin_keys,
			plugin = wk_plugin.name,
			icon = { icon = "⌨", color = "blue" },
			desc = "Nvim-surround",
			mode = { "n", "x" },
		},
	})
	local wk_plugins = require("which-key.plugins")
	wk_plugins.plugins[wk_plugin.name] = wk_plugin
	wk_plugins._setup(wk_plugin, {})
	-- Hook nvim-surround so it asks us (via which-key) for the surround char.
	require("nvim-surround.input").get_char = get_char
end

-- which-key (plugin/vfx.lua) is set up later while plugin/ files are sourced.
-- Defer until after startup so it is available regardless of source order.
vim.schedule(attach)
