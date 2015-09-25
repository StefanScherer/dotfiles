#!/bin/bash
sudo find /private/var/folders -type f -name "*.pkg" | xargs -I {} sh -c 'base=$(basename "$1"); echo "$base"; ln "$1" "/Users/stefan/Downloads/_MAS_$base"' -- {}
