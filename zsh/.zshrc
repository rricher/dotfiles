# add oh my posh to the path
path+=('/home/ryan/bin')
export PATH


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

autoload -U select-word-style
select-word-style bash

# Add in zsh plugins
zinit light jirutka/zsh-shift-select
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# start oh-my-posh and add the theme
# eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/rudolfs-light.omp.json)"
eval "$(oh-my-posh init zsh --config /home/ryan/.config/ohmyposh/zen.toml)"

# Load completions
autoload -U compinit; compinit

zinit cdreplay -q

# Keybindings
# Ctrl + arrow keys to move between words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# for history substring search
bindkey "$terminfo[kcuu1]" history-search-backward
bindkey "$terminfo[kcud1]" history-search-forward

# History
HISTSIZE=5000 # number of lines to keep in memory
HISTFILE=~/.zsh_history # file to save history to
SAVEHIST=$HISTSIZE # number of lines to save to file
HISTDUP=erase # erase duplicates in history
setopt appendhistory # append history to file
setopt sharehistory # share history between sessions
setopt hist_ignore_space # ignore commands starting with space
setopt hist_ignore_all_dups # ignore all duplicates in history
setopt hist_save_no_dups # do not save duplicates in history
setopt hist_ignore_dups # ignore duplicates in history
setopt hist_find_no_dups # do not display duplicates when searching history

ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# turn off default zsh completion menu for fzf-tab
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# fzf-tab completion for file path browsing
# zstyle ':fzf-tab:*' continuous-trigger "$terminfo[kcuf1]"

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lah'
alias sudo='sudo -E'

# Append this line to ~/.zshrc to enable fzf keybindings for Zsh:
source /usr/share/doc/fzf/examples/key-bindings.zsh
# Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:
source /usr/share/doc/fzf/examples/completion.zsh




export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
