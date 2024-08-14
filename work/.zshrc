# add some things to path
path+=("$HOME/.local/bin")
# export to sub-processes (make it inherited by child processes)
export PATH

# set the dierecotry we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"


# Download Zinit, if it"s not there yet
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

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5A" history-search-backward
bindkey "^[[1;5B" history-search-forward

# load some zinit annexs
zinit wait lucid light-mode for \
        zdharma-continuum/zinit-annex-patch-dl \
        zdharma-continuum/zinit-annex-submods \
        zdharma-continuum/zinit-annex-linkman \
        zdharma-continuum/zinit-annex-bin-gem-node \
        jirutka/zsh-shift-select 

zinit wait"0a" lucid blockf atpull'zinit creinstall -q .' for \
    atload"zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}';
        zstyle ':completion:*:git-checkout:*' sort false;
        zstyle ':completion:*:descriptions' format '[%d]';
        zstyle ':completion:*' menu no" \
        zsh-users/zsh-completions


zinit wait"0b" lucid atinit"zicompinit; zicdreplay" for \
      zdharma-continuum/fast-syntax-highlighting

zinit wait lucid atload'_zsh_autosuggest_start' for \
    zsh-users/zsh-autosuggestions

zinit wait"0b" lucid light-mode for \
    pack'no-dir-color-swap' atload"zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}" \
        trapd00r/LS_COLORS 

zinit wait"0b" lucid light-mode for \
    blockf compile'lib/*f*~*.zwc' \
    atload"zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'" \
        Aloxaf/fzf-tab 

zinit wait"0c" light-mode atclone'mkdir -p $ZPFX/{bin,man/man1}' \
    atpull'%atclone' \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf_completion;
      https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh;
      https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/man/man1/fzf.1' \
    from'gh-r' \
    id-as'junegunn/fzf' \
    lucid \
    nocompile \
    pick'/dev/null' \
    sbin'fzf' \
    src'key-bindings.zsh' for \
        junegunn/fzf

# configure oh-my-posh
# eval "$(oh-my-posh init zsh)"
# eval "$(oh-my-posh init zsh --config $HOME/.dotfiles/home/oh-my-posh/.config/oh-my-posh/zen.json)"
# pre cmd for omp atload'_omp_precmd'
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"

# Keybindings
# bindkey "^f" autosuggest-accept
# bindkey "^[[1;3C" continuous-trigger
# bindkey "^[w" kill-region

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
# ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)

# Completion styling
# make completion case insensitive
# zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
# disable sort when completing `git checkout`
# zstyle ":completion:*:git-checkout:*" sort false
# set descriptions format to enable group support
# NOTE: don"t use escape sequences here, fzf-tab will ignore them
# zstyle ":completion:*:descriptions" format "[%d]"
# set list-colors to enable filename colorizing
# zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ":completion:*" menu no
# preview directory"s content with eza when completing cd
# zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls $realpath"
# switch group using `<` and `>`
# zstyle ":fzf-tab:*" switch-group "<" ">"

# Aliases
alias ls="ls --color --group-directories-first"
alias l="ls -d  */"
alias la="ls -A"
alias ll="ls -alh"
alias c="clear"
alias sudo="sudo -E"

# Shell integrations
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh
