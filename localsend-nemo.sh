#!/bin/bash
LOCALSEND="flatpak run org.localsend.localsend_app"

# Check if LocalSend is running
if ! pgrep -f "org.localsend.localsend_app" > /dev/null; then
    # Start normally (not minimized) since this is from Nemo
    $LOCALSEND &
    sleep 3
else
    # If already running, bring it to foreground
    if command -v wmctrl &> /dev/null; then
        wmctrl -a "LocalSend" || true
    fi
fi

# Send selected files/folders
for f in "$@"; do
    $LOCALSEND "$f" &
done

