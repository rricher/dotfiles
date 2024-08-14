# set the dierecotry we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# add some things to path
# append
path+=('/home/richerr/.local/bin')
# export to sub-processes (make it inherited by child processes)
export PATH

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "$ZINIT_HOME/zinit.zsh"

# implement moving over and editing words where only alphanumeric characters are considered word characters
# esentialy will ignore -_/\. characters so it doesnt just the whole path
# must come before loading syntax highlighting
autoload -U select-word-style
select-word-style bash

# Add in zsh plugins
zinit light jirutka/zsh-shift-select
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# configure oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"

# Keybindings
# bindkey '^f' autosuggest-accept
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# bindkey '^[[1;3C' continuous-trigger
# bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# adjust zsh hightlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)

# Completion styling
# make completion case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
# switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'

# Aliases
alias ls='ls --color --group-directories-first'
alias l='ls -d  */'
alias ll='ls -alh'
alias c='clear'
alias sudo='sudo -E'

# Shell integrations
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
