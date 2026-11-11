#!/bin/sh
while true; do
    # Get Volume Percentage from WirePlumber
    VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)"%"}')
    # Check if Audio is Muted
    if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
        VOL="MUTED"
    fi

    # Get Brightness Percentage from brightnessctl
    BRIGHT=$(brightnessctl -m | awk -F, '{print int(($4/$3)*100)"%"}')

    # Output to Sway Bar
    echo "🔊 Vol: $VOL | ☀️ Bright: $BRIGHT | 🗓️ $(date +'%Y-%m-%d %l:%M:%S %p')"
    
    sleep 1
done

