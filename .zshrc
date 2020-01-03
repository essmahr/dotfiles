export ZSH=~/.oh-my-zsh

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

source $HOME/.scm_breeze/scm_breeze.sh

# load exports
source ~/.exports

# load custom executable functions
for function in ~/.functions/*; do
  source $function
done
unset function;

# load custom aliases
for alias in ~/.aliases/*; do
  source $alias
done
unset alias;

# direnv
eval "$(direnv hook zsh)"

# rbenv
eval "$(rbenv init -)"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


