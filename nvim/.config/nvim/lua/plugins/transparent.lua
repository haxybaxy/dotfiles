return {
		'xiyaowong/transparent.nvim',
		config = function()
			require('transparent').setup({
				enable = true,
				extra_groups = {
					'GitSignsAdd',
					'GitSignsChange',
					'GitSignsDelete',
				},
				icons = false,
				hiLine = 'Normal',
				hiGroup = 'Normal',
			})
		end,
	}
