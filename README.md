# dotfiles

Add some tweaks into current Unix/Ubuntu user's home directory.
Inspired by <https://github.com/paulirish/dotfiles> for MacOS.
For Windows I prefer my <https://github.com/StefanScherer/dotfiles-windows>.

# Installation
    git clone https://github.com/StefanScherer/dotfiles && cd dotfiles && ./sync.sh

To update later on, just run the sync.sh again.

### Tools

* **addtime**: show relative time stamp in stdout of another tool.
  Usage: anothertool | addtime
* **timeref**: show relative time diffs in logfile.
  Usage: timeref logfile | gvim -

### Aliases

* **solarize**: change between **dark** and **light** in terminal
* **..**: one dir up
* **...**: two dirs up
* **....**: three dirs up
* **.....**: four dirs up
* **~**: go into users home directory
* **hosts**: edit your hosts file, if sudo is missing, call `cinst sudo`
* **logvi logfile**: view a log file with relative times in gvim

### Sublime Text 3

My preferences for Sublime Text 3 are also stored in the repo. Be aware.
To have sublime in command line, I use following symlink:

```
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/bin/subl
```


### VIM

* installs **Vundle** and some other stuff
* **nerdtree**
* **vim-colors-solarized**
* **YouCompleteMe**

### VIM commands

* `,c`: show trailing white space
* `,ss`: strip trailing white space
* `,e`: format JavaScript code with esformatter (`npm install -g esformatter`)

# Licensing
Copyright (c) 2014 Stefan Scherer

MIT License, see LICENSE.txt for more details.
