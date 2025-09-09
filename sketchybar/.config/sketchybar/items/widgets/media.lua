local colors = require("config.colors")
local icons = require("config.icons")

local MAX_TEXT_LENGTH = 40

local current_playing = false
local current_media_text = ""

local function truncate_text(text)
  if #text <= MAX_TEXT_LENGTH then
    return text
  end
  return string.sub(text, 1, MAX_TEXT_LENGTH - 3) .. "..."
end

local media = sbar.add("item", "media_ctrl.anchor", {
  position = "right",
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
  drawing = true,
})

media:subscribe("media_stream_changed", function(env)
  local title = env.title or ""
  local artist = env.artist or ""
  
  if title ~= "" and title ~= "null" then
    local media_text = title
    if artist ~= "" and artist ~= "null" then
      media_text = artist .. " - " .. title
    end
    
    local display_text = truncate_text(media_text)
    current_media_text = display_text
    
    -- Get current playing state from media-control for the icon
    sbar.exec(
      'media-control get 2>/dev/null | jq -r "if . == null then \"false\" else (if .playing then \"true\" else \"false\" end) end"',
      function(result, exit_code)
        local playing = false
        if exit_code == 0 and result then
          playing = string.lower(string.gsub(result or "", "%s+", "")) == "true"
        end
        
        current_playing = playing
        local play_icon = playing and icons.text.media.pause or icons.text.media.play
        
        media:set({
          icon = { string = play_icon },
          label = { string = display_text },
        })
      end
    )
  else
    -- No media playing
    current_playing = false
    current_media_text = ""
    media:set({
      icon = { string = "" },
      label = { string = "" },
    })
  end
end)

media:subscribe("mouse.clicked", function()
  if current_media_text ~= "" then
    -- Immediately toggle the visual state for instant feedback
    current_playing = not current_playing
    local immediate_icon = current_playing and icons.text.media.pause or icons.text.media.play

    media:set({
      icon = { string = immediate_icon },
      label = { string = current_media_text },
      drawing = true,
    })

    sbar.exec("media-control toggle-play-pause")
  end
end)
