local padding = {
  background = 8,
  icon = 10,
  label = 8,
  bar = 0,
  left = 8,
  right = 8,
  item = 18,
  popup = 8,
}

local graphics = {
  bar = {
    height = 36,
    offset = 0,
  },
  background = {
    height = 24,
    corner_radius = 5,
  },
  slider = {
    height = 20,
  },
  popup = {
    width = 200,
    large_width = 300,
  },
  blur_radius = 0,
}

local text ={
  icon = 14.0,
  label = 14.0,
}

return {
  padding = padding,
  graphics = graphics,
  text = text,
}
