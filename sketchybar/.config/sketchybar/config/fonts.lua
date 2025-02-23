local dimens <const> = require("config.dimens")

return {
  text = "FiraCode Nerd Font",
  numbers = "FiraCode Nerd Font",
  icons = function(size)
    local font = "sketchybar-app-font:Regular"
    return size and font .. ":" .. size or font .. ":" .. dimens.text.icon
  end,
  styles = {
    regular = "Regular",
    bold = "Bold",
  }
}
