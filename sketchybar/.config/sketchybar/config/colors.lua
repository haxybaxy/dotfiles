local colors = {
  black = 0xff181819,
  white = 0xfff8f8f2,
  red = 0xfff38ba8,
  green = 0xffa6e3a1,
  blue = 0xff89b4fa,
  yellow = 0xfff9e2af,
  orange = 0xfffab387,
  magenta = 0xd3fc7ebd,
  purple = 0xff796fa9,
  other_purple = 0xff302c45,
  cyan = 0xff7bf2de,
  grey = 0xff7f8490,
  dirty_white = 0xc8cad3f5,
  dark_grey = 0xff2b2736,
  transparent = 0x00000000,
  bar = {
    bg = 0x0d000000, -- as transparent as possible while still being clickable
    border = 0xff2c2e34,
  },
  popup = {
    bg = 0xf1151320,
    border = 0xff2c2e34,
  },
  slider = {
    bg = 0xf1151320,
    border = 0xff2c2e34,
  },
  bg1 = 0xd3282c34,
  bg2 = 0xff302c45,

with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then
        return color
    end
    local bit = require("bit")
    return bit.bor(
        bit.band(color, 0x00ffffff),
        bit.lshift(math.floor(alpha * 255.0), 24)
    )
end,

}

return colors
