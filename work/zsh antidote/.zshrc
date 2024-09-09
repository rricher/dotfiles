#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"

# Zsh options.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# implement moving over and editing words where only alphanumeric characters are considered word characters
# esentialy will ignore -_/\. characters so it doesnt just the whole path
# must come before loading syntax highlighting
# zsh-utils wordchars
# WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
# windows terminal word delimiters
# WORDCHARS=' /\()"'-.,:;<>~!@#$%^&*|+=[]{}~?│'
autoload -U select-word-style
select-word-style bash

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5A" history-search-backward
bindkey "^[[1;5B" history-search-forward

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

eval "$(zoxide init --cmd cd zsh)"
