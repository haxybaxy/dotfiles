local settings = require("config.settings")

sbar.bar({
	topmost = "window",
	height = settings.dimens.graphics.bar.height,
	color = settings.colors.bar.bg,
	padding_right = settings.dimens.padding.right,
	padding = settings.dimens.padding.bar,
	padding_left = settings.dimens.padding.left,
	margin = settings.dimens.padding.bar,
	corner_radius = 0,
	y_offset = settings.dimens.graphics.bar.offset,
	-- blur_radius = settings.dimens.graphics.blur_radius,
	border_width = 0,
})
