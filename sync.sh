#!/bin/bash
cd "$(dirname "$0")"
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
          git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
          sudo apt-get install build-essential cmake python-dev
          (cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.sh --clang-completer)
        fi
        # solarized
        if [ ! -d ~/.solarized ]; then
          git clone https://github.com/gmodarelli/solarize.git ~/.solarized
          chmod +x ~/.solarized/solarize.sh
        fi
        ~/.solarized/solarize.sh light

	rsync --exclude ".git/" --exclude "sync.sh" --exclude "README.md" --exclude "LICENSE" --exclude ".gitkeep" -av . ~
        vim +BundleInstall +qall
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
