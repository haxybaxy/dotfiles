return {
	{ -- close unused buffers automatically
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},
	-- { -- auto-save and ressurect sessions
	--   "rmagatti/auto-session",
	--   lazy = false,
	--   opts = {
	--     suppressed_dirs = { "~/", "~/Downloads", "/" },
	--   },
	-- },
}
