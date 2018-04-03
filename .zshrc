export ZSH=/Users/smahr/.oh-my-zsh

ZSH_THEME="agnoster"

# User configuration for agnoster theme
DEFAULT_USER="smahr"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# plugins=(rails git textmate ruby lighthouse)

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Source relevent dotfiles
for file in ~/.{aliases,exports,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# reading .nvmrc on login and directory change
autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# rvm
export PATH="$PATH:$HOME/.rvm/bin"

# composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# yarn
export PATH="$HOME/.yarn/bin:$PATH"
