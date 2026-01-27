#!/bin/bash
current_workspace=$(aerospace list-workspaces --focused)

aerospace list-windows --all \
  | grep -Ei "Finder|Antinote" \
  | awk '{print $1}' \
  | while read -r window_id; do
      aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
    done

