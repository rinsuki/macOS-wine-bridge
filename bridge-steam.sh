#!/bin/sh

# Run a Steam Play game with macOS-wine-bridge
# Set the game's launch options to: /path/to/this-script.sh %command%
basedir=$(dirname "$(readlink -f $0)")

BRIDGE="$basedir/bridge.exe"
DELAY=10 # how many seconds to wait after starting the bridge before starting the game

"$1" run "$BRIDGE" &
sleep "$DELAY"
"$1" run "${@:3}"

