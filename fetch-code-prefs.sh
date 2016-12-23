#!/bin/bash
# This is a helper to fetch my Visual Studio Code prefs to fetch it into the repo for commit and push
# OSX
cp ~/Library/Application\ Support/Code/User/*.json ./Library/Application\ Support/Code/User/
code --list-extensions >./Library/Application\ Support/Code/User/extensions.txt
