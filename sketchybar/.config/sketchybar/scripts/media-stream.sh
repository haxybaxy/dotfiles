title=""
artist=""
playing="false"

media-control stream | \
    while IFS= read -r line; do
        # Get the diff flag
        diff=$(jq -r '.diff' <<< "$line")
        
        new_title=$(jq -r 'if .payload.title then .payload.title else empty end' <<< "$line")
        new_artist=$(jq -r 'if .payload.artist then .payload.artist else empty end' <<< "$line")
        new_playing=$(jq -r 'if .payload.playing != null then .payload.playing else empty end' <<< "$line")
        
        if [ -n "$new_title" ] && [ "$new_title" != "null" ]; then
            title="$new_title"
        fi
        if [ -n "$new_artist" ] && [ "$new_artist" != "null" ]; then
            artist="$new_artist"
        fi
        if [ -n "$new_playing" ] && [ "$new_playing" != "null" ]; then
            playing="$new_playing"
        fi
        
        sketchybar --trigger media_stream_changed title="$title" artist="$artist" playing="$playing"
    done

