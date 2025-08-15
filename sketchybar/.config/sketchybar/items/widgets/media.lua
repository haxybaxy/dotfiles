local constants = require("constants")
local colors = require("config.colors")
local icons = require("config.icons")
local settings = require("config.settings")

-- Text truncation configuration
local MAX_TEXT_LENGTH = 35 -- Maximum characters to display

-- Track current playing state for immediate feedback
local current_playing = false
local current_media_text = ""

-- Function to truncate text
local function truncate_text(text)
  if #text <= MAX_TEXT_LENGTH then
    return text
  end
  return string.sub(text, 1, MAX_TEXT_LENGTH - 3) .. "..."
end

-- Simple media control widget using media-control
local media = sbar.add("item", "media_ctrl.anchor", {
  position = "right",
  update_freq = 2, -- Update every 2 seconds
  label = {
    string = "No Media",
    color = colors.white,
    padding_left = 8,
    padding_right = 8,
  },
  icon = {
    string = icons.text.media.pause,
    color = colors.white,
    padding_left = 8,
  },
  background = {
    color = 0x11000000, -- keep it kind of transparent to make it clickable 
    border_width = 0,
    corner_radius = 6,
    height = 24,
  },
  drawing = true, -- Always show initially
})

media:subscribe("routine", function()
  -- Get all media info in one clean command using jq
  sbar.exec("media-control get 2>/dev/null | jq -r 'if . == null then \"||false\" else .title + \"|\" + (.artist // \"\") + \"|\" + (if .playing then \"true\" else \"false\" end) end'", function(result, exit_code)
    -- Always ensure the widget is responsive by setting drawing = true initially
    local has_valid_media = false
    
    if exit_code == 0 and result and result ~= "" and result ~= "null|null|null" and result ~= "||false" then
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
      
      if track ~= "" and track ~= "null" and track ~= "nil" then
        has_valid_media = true
        
        -- Create display text
        local media_text = track
        if artist ~= "" and artist ~= "null" and artist ~= "nil" then
          media_text = track .. " - " .. artist
        end

        -- Truncate text if too long
        local display_text = truncate_text(media_text)

        -- Update tracked state
        current_playing = playing
        current_media_text = display_text

        -- Update play/pause icon
        local play_icon = playing and icons.text.media.pause or icons.text.media.play
        
        -- Show the widget with media info
        media:set({
          icon = { string = play_icon },
          label = { string = display_text },
          drawing = true,
          background = {
            color = 0x11000000, -- Semi-transparent background when media is present
            border_width = 0,
            corner_radius = 6,
            height = 24,
          },
        })
      end
    end
    
    -- Show empty content if no valid media (but keep widget visible)
    if not has_valid_media then
      current_playing = false
      current_media_text = ""
      media:set({
        icon = { string = "" },
        label = { string = "" },
        drawing = true,
        background = {
          color = 0x00000000, -- Fully transparent when no media
          border_width = 0,
          corner_radius = 6,
          height = 24,
        },
      })
    end
  end)
end)

-- Click handler for play/pause toggle
media:subscribe("mouse.clicked", function()
  -- Only handle clicks if we have valid media
  if current_media_text ~= "" then
    -- Immediately toggle the visual state for instant feedback
    current_playing = not current_playing
    local immediate_icon = current_playing and icons.text.media.pause or icons.text.media.play
    
    media:set({
      icon = { string = immediate_icon },
      label = { string = current_media_text },
      drawing = true,
    })
    
    -- Execute the actual toggle command
    sbar.exec("media-control toggle-play-pause")
  end
end)
