# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"

if [ -e $HOME/go/bin ]; then
  export PATH="$PATH:$HOME/go/bin"
fi
if [ -e /Applications/Packer ]; then
  export PATH="$PATH:/Applications/Packer"
fi

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# init z   https://github.com/rupa/z
. ~/code/z/z.sh

# init rvm
if [ -e $HOME/.rvm/scripts/rvm ]; then
  source ~/.rvm/scripts/rvm
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

source ~/bin/git-completion.bash

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# autoenv
[[ -s /usr/local/opt/autoenv/activate.sh ]] && source /usr/local/opt/autoenv/activate.sh

# GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
