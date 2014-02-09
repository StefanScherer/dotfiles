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
	rsync --exclude ".git/" --exclude "sync.sh" --exclude "README.md" --exclude "LICENSE" -av . ~
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
