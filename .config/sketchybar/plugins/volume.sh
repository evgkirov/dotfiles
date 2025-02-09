#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.
if system_profiler SPAudioDataType -json | jq -r '.SPAudioDataType[]._items[] | select(._name=="REIYIN Audio") | .coreaudio_default_audio_output_device' | grep -q 'spaudio_yes'; then
    VOLUME=$(osascript -e 'tell application "Menu Bar Controller for Sonos" to return currentVolume of first group whose name contains "Office"')
else
    if [ "$SENDER" = "volume_change" ]; then
        VOLUME=$INFO
    else
        VOLUME=$(osascript -e 'output volume of (get volume settings)')
    fi
fi

case $VOLUME in
[6-9][0-9] | 100)
    ICON="󰕾"
    ;;
[3-5][0-9])
    ICON="󰖀"
    ;;
[1-9] | [1-2][0-9])
    ICON="󰕿"
    ;;
*) ICON="󰖁" ;;
esac

sketchybar --set $NAME icon="$ICON" label="$VOLUME%"
