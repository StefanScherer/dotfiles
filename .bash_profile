# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"
if [ -e /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
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

# WSL
if [ -d /mnt/c ]; then
  for file in ~/.{bash_profile_wsl,aliases_wsl,functions_wsl}; do
    [ -r "$file" ] && source "$file"
  done
  unset file
fi

if [ -e /opt/homebrew/bin/infra-cli ]; then
  eval "$(infra-cli aliases)"
fi

if [ -e /usr/local/bin/infra-cli ]; then
  eval "$(infra-cli aliases)"
fi

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

if [[ "$OSTYPE" == "darwin"*  ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
  export PATH="/usr/local/opt/node@12/bin:$PATH"
fi
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# autoenv
[[ -s /usr/local/opt/autoenv/activate.sh ]] && source /usr/local/opt/autoenv/activate.sh

# GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
#export GOVERSION=1.12.1
#export GOROOT=${HOME}/.pinata/cache/go${GOVERSION}/go
#export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

if [ -f "$HOME/code/azure-cli/az.completion" ]; then
  source "$HOME/code/azure-cli/az.completion"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/opt/ruby/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi
export GPG_TTY=$(tty)
