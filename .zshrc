export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"

# User configuration for agnoster theme
DEFAULT_USER="smahr"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# plugins=(rails git textmate ruby lighthouse)

JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

export PATH="$PATH:$PYENV_ROOT/bin:$HOME/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

source $HOME/.scm_breeze/scm_breeze.sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

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
# eval "$(direnv hook zsh)"

# rbenv
# eval "$(rbenv init -)"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


# chruby
source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh # automatically switch ruby version

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# pnpm
export PNPM_HOME="/Users/scottmahr/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
