media-control stream | \
    while IFS= read -r line; do
        if [ "$(jq -r '.diff == false' <<< "$line")" = "true" ]; then
            title=$(jq -r '.payload.title' <<< "$line")
            artist=$(jq -r '.payload.artist' <<< "$line")
            sketchybar --trigger media_stream_changed title="$title" artist="$artist"
        fi
    done

