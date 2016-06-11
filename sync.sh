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
  if [ ! -d ~/.vim/bundle/YouCompleteMe ]; then
    if [ "$1" == "--all" -o "$1" == "-a" ]; then
      shift
      git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
      sudo apt-get install -y build-essential cmake python-dev
      (cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.sh --clang-completer)
    fi
  fi
  # solarized
  if [ ! -d ~/.solarized ]; then
    git clone https://github.com/gmodarelli/solarize.git ~/.solarized
    chmod +x ~/.solarized/solarize.sh
  fi
  ~/.solarized/solarize.sh light

  rsync --exclude ".git/" --exclude "images/" --exclude "sync.sh" --exclude "README.md" --exclude "npm-install.sh" --exclude "LICENSE.txt" --exclude ".gitkeep" --exclude "fetch-sublime-prefs.sh" --exclude "fetch-atom-prefs.sh" -av . ~
  if which vim >/dev/null 2>&1; then
    vim +BundleInstall +qall
  fi
  if [ ! -d ~/.atom/packages/parcel ]; then
    if which apm >/dev/null 2>&1; then
      apm install parcel
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
