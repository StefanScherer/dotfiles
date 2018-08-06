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
  if [ ! -d ~/.logs ]; then
    mkdir ~/.logs
    chmod 700 ~/.logs
  fi
  if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  fi

  rsync --exclude ".git/" --exclude "images/" \
        --exclude "sync.sh" --exclude "README.md" \
        --exclude "npm-install.sh" --exclude "LICENSE.txt" \
        --exclude ".gitkeep" --exclude ".gitconfig" --exclude "fetch-sublime-prefs.sh" \
        --exclude "fetch-atom-prefs.sh" -av . ~
  if [ ! -f ~/.gitconfig ]; then
    cp .gitconfig ~/.gitconfig
  fi

  if [ -d /mnt/c ]; then
    echo Copy WSL vmrun helper script
    sudo cp bin/vmrun.exe-helper "/usr/bin/C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"
  fi

  if which vim >/dev/null 2>&1; then
    vim +BundleInstall +qall
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

  # Atom
  if command -v apm > /dev/null 2>&1; then
    echo "Installing Atom plugins..."
    ~/code/dotfiles/install-atom-plugins.sh
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
