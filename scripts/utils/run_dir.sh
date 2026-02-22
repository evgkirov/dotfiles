#!/bin/bash

DIR="$1"

for script in "$DIR"/*.sh; do
    if [ -f "$script" ]; then
        echo "📃 $script"
        sh "$script"
    fi
done
