#!/bin/bash
vol=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
if [[ "$vol" == *'[MUTED]'* ]]; then
    /usr/bin/printf '{"text": "󰍭", "class": "muted"}\n'
else
    /usr/bin/printf '{"text": "󰍬", "class": "active"}\n'
fi
