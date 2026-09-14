#!/bin/bash
_pending_pid=

while read -r _; do
    kill "$_pending_pid" 2>/dev/null
    { sleep 0.1; pkill -SIGRTMIN+8 waybar; } &
    _pending_pid=$!
done < <(pactl subscribe | grep --line-buffered 'source')
