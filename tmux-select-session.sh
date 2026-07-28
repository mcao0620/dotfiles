#!/bin/sh

session_index="$1"
session_id="$(tmux list-sessions -F '#{session_id}' | sed -n "${session_index}p")"

if [ -n "$session_id" ]; then
  tmux switch-client -t "$session_id"
fi
