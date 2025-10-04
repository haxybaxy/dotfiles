#!/usr/bin/env bash

# Constants
WORK_DIR="$HOME/work"

# Functions
get_current_session() {
    [[ -n $TMUX ]] && tmux display-message -p '#S'
}

find_work_directories() {
    find "$WORK_DIR" -mindepth 1 -maxdepth 1 -type d
}

sanitize_name() {
    basename "$1" | tr . _
}

find_current_directory() {
    local session_name=$1
    local all_dirs=$2
    
    while IFS= read -r dir; do
        if [[ "$(sanitize_name "$dir")" == "$session_name" ]]; then
            echo "$dir"
            return
        fi
    done <<< "$all_dirs"
}

select_directory_with_fzf() {
    local current_session=$1
    local all_dirs=$2
    
    if [[ -z $current_session ]]; then
        echo "$all_dirs" | fzf
        return
    fi
    
    local current_dir=$(find_current_directory "$current_session" "$all_dirs")
    
    if [[ -n $current_dir ]]; then
        local other_dirs=$(echo "$all_dirs" | grep -v "^$current_dir$")
        printf "%s\n%s" "$other_dirs" "$current_dir" | \
            sed "s|$HOME/||" | \
            fzf --header="Current session: $current_session"
    else
        echo "$all_dirs" | sed "s|$HOME/||" | fzf
    fi
}

ensure_session_exists() {
    local session_name=$1
    local directory=$2
    
    if ! tmux has-session -t="$session_name" 2>/dev/null; then
        tmux new-session -ds "$session_name" -c "$directory"
    fi
}

attach_or_switch_session() {
    local session_name=$1
    
    if [[ -z $TMUX ]]; then
        tmux attach -t "$session_name"
    else
        tmux switch-client -t "$session_name"
    fi
}

# Main script
main() {
    local selected
    
    # Get selected directory
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        local current_session=$(get_current_session)
        local all_dirs=$(find_work_directories)
        selected=$(select_directory_with_fzf "$current_session" "$all_dirs")
        
        [[ -z $selected ]] && exit 0
        selected="$HOME/$selected"
    fi
    
    local selected_name=$(sanitize_name "$selected")
    
    # Handle tmux not running
    if [[ -z $TMUX ]] && [[ -z $(pgrep tmux) ]]; then
        tmux new-session -s "$selected_name" -c "$selected"
        exit 0
    fi
    
    # Ensure session exists and attach/switch to it
    ensure_session_exists "$selected_name" "$selected"
    attach_or_switch_session "$selected_name"
}

main "$@"
