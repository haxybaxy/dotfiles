#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  # Get the icon for the app
  icon=$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$INFO")

  # Update both icon and label
  sketchybar --set "$NAME" icon="$icon" label="$INFO"
fi
