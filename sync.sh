#!/bin/bash
cd "$(dirname "$0")" || exit 5
git pull

function doIt() {
  if [ ! -d ~/code ]; then
    mkdir ~/code
  fi
  if [ ! -d ~/code/z ]; then
    git clone https://github.com/rupa/z.git ~/code/z
  fi
  if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  fi

  # solarized
  if [ ! -d ~/.solarized ]; then
    git clone https://github.com/gmodarelli/solarize.git ~/.solarized
    chmod +x ~/.solarized/solarize.sh
  fi
  ~/.solarized/solarize.sh light

  rsync --exclude ".git/" --exclude "images/" \
        --exclude "sync.sh" --exclude "README.md" \
        --exclude "npm-install.sh" --exclude "LICENSE.txt" \
        --exclude ".gitkeep" --exclude "fetch-sublime-prefs.sh" \
        --exclude "fetch-atom-prefs.sh" -av . ~
  if which vim >/dev/null 2>&1; then
    vim +BundleInstall +qall
  fi

  # Atom
  if [ ! -d ~/.atom/packages/parcel ]; then
    if which apm >/dev/null 2>&1; then
      apm install parcel
    fi
  fi

  # Visual Studio Code
  if [ -f ./Library/Application\ Support/Code/User/extensions.txt ]; then
    extensions=$(cat ./Library/Application\ Support/Code/User/extensions.txt)
    if [ ! -d /mnt/c ]; then
      if which code >/dev/null 2>&1; then
        for ext in $extensions; do
          code --install-extension "$ext"
        done
      fi
    fi
  fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi

unset doIt
source ~/.bash_profile
