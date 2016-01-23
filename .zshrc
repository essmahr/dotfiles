export ZSH=/Users/smahr/.oh-my-zsh

ZSH_THEME="agnoster"

# User configuration for agnoster theme
DEFAULT_USER="smahr"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# TODO: where do these go
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
