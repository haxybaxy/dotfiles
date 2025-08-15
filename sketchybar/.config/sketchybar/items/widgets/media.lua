local constants = require("constants")
local colors = require("config.colors")
local icons = require("config.icons")

-- Simple media control widget using media-control
local media = sbar.add("item", "media_ctrl.anchor", {
  position = "right",
  update_freq = 2, -- Update every 5 seconds
  label = {
    string = "No Media",
    color = colors.white,
  },
  icon = {
    string = icons.text.media.pause,
    color = colors.white,
  },
  drawing = true, -- Always show initially
})

media:subscribe("routine", function()
  -- Get all media info in one clean command using jq
  sbar.exec("media-control get 2>/dev/null | jq -r '.title + \"|\" + (.artist // \"\") + \"|\" + (if .playing then \"true\" else \"false\" end)'", function(result, exit_code)
    if exit_code == 0 and result and result ~= "" and result ~= "null|null|null" then
      -- Split the result by the delimiter
      local parts = {}
      for part in result:gmatch("([^|]*)") do
        table.insert(parts, part)
      end
      
      local track = parts[1] or ""
      local artist = parts[2] or ""
      local playing_str = parts[3] or "false"
      -- Trim whitespace and check for true
      local playing = string.lower(string.gsub(playing_str or "", "%s+", "")) == "true"
      
      if track ~= "" and track ~= "null" then
        -- Create display text
        local media_text = track
        if artist ~= "" and artist ~= "null" then
          media_text = track .. " - " .. artist
        end

        -- Update play/pause icon
        local play_icon = playing and icons.text.media.pause or icons.text.media.play
        
        -- Show the widget with media info
        media:set({
          icon = { string = play_icon },
          label = { string = media_text },
          drawing = true,
        })
      else
        -- Hide widget when no valid title
        media:set({
          icon = { string = "􀊄" },
          label = { string = "No Media" },
          drawing = false,
        })
      end
    else
      -- Hide widget when command fails or no media
      media:set({
        icon = { string = "􀊄" },
        label = { string = "No Media" },
        drawing = false,
      })
    end
  end)
end)

-- Click handler for play/pause toggle
media:subscribe("mouse.clicked", function()
  sbar.exec("media-control toggle-play-pause")
end)