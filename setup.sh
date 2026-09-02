#!/bin/bash

shopt -s nullglob

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

  # Claude Code
  #
  # only link individual config files rather than symlinking the directory to
  # sidestup session/state stuff
  user "Symlinking Claude Code config."
  mkdir -p "$HOME/.claude"
  link "`pwd`/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  # Claude Code saves settings via temp file + rename, which replaces the
  # symlink with a real file. Adopt those edits into the repo before relinking.
  if [[ -f "$HOME/.claude/settings.json" && ! -L "$HOME/.claude/settings.json" ]]; then
    cp "$HOME/.claude/settings.json" claude/settings.json
  fi
  link "`pwd`/claude/settings.json" "$HOME/.claude/settings.json"
  info "Claude Code config symlinked."

  # Skills: per-skill symlinks into a real ~/.claude/skills. Claude follows
  # symlinked entries, and a real dir leaves room for local-only skills.
  user "Symlinking Claude Code skills."
  mkdir -p "$HOME/.claude/skills"
  for skill in claude/skills/*/; do
    skill="${skill%/}"
    link "`pwd`/$skill" "$HOME/.claude/skills/$(basename "$skill")"
  done
  for existing in "$HOME"/.claude/skills/*; do
    [[ -L "$existing" ]] || continue
    [[ "$(readlink "$existing")" == "`pwd`/claude/skills/"* ]] || continue
    [[ -e "$existing" ]] && continue
    rm "$existing"
  done
  info "Claude Code skills symlinked."

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
