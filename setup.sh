#!/bin/zsh

user() {
  printf "\r\033[00;34m[ .. ] »\033[0m $1\n"
}

info() {
  printf "\r\033[0;33m[ ?? ] »\033[0m $1\n"
}

success() {
  printf "\r\033[00;32m[ !! ] »\033[0m $1\n"
}

link() {
  rm -f "$2"
  ln -s "$1" "$2"
}

begin() {
  # Symlink all the things
  user "Symlinking dotfiles."
  for file in .[^.]*; do
    [[ $file =~ (.git|.DS_Store)$ ]] && continue
    link "`pwd`/$file" "$HOME/$file"
  done
  info "Dotfiles symlinked."

  # user "Symlinking functions directory"
  # link "`pwd`/.functions/" "$HOME/.functions"

  # Do the OSX thing
  # user "Loading OSX preferences. You will need to enter your password."
  # zsh ./.osx
  # info "OSX preferences loaded. Note that some of these changes require a logout/restart to take effect."

  success "Everything worked!"

  # Reload ZSH
  user "Reloading ZSH..."
  exec zsh;
}

# Optionally force
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  begin;
else
  info "This script will symlink everything from this directory to your home directory."
  info "These dotfiles may overwrite existing ones in your home directory."
  read -p "Are you absolutely sure you want to continue? (Yn)" -n 1;
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "";
    user "Sounds good. Let's go!"
    begin;
  fi;
fi;

unset begin;
