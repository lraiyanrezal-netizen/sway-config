#!/bin/bash
while true; do
    # Capture the exact raw line output for Mono from your card state
    vol_info=$(amixer get Master | grep -E "^\s*Mono:")

    # Handle mute detection robustly by searching for raw text matches
    case "$vol_info" in
        *"[off]"* | "")
            vol_out="MUTE"
            ;;
        *)
            # Extract whatever sits inside the very first set of brackets safely
            vol_out=$(echo "$vol_info" | awk -F"[][]" '{print $2}')
            ;;
    esac

    # Extract panel backlighting configuration
    bright_pct=$(brightnessctl -m | awk -F, '{print $4}')

    # Output a single, perfectly formatted line to your Swaybar
    echo "VOL: $vol_out | BRIGHT: $bright_pct | $(date +'%Y-%m-%d %H:%M')"
    sleep 1
done
