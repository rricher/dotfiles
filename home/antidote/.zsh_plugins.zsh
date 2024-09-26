fpath+=( $HOME/.cache/antidote/zsh-users/zsh-completions/src )
fpath+=( $HOME/.cache/antidote/mattmc3/ez-compinit )
source $HOME/.cache/antidote/mattmc3/ez-compinit/ez-compinit.plugin.zsh
fpath+=( $HOME/.cache/antidote/Aloxaf/fzf-tab )
source $HOME/.cache/antidote/Aloxaf/fzf-tab/fzf-tab.plugin.zsh
fpath+=( $HOME/.cache/antidote/jirutka/zsh-shift-select )
source $HOME/.cache/antidote/jirutka/zsh-shift-select/zsh-shift-select.plugin.zsh
source $ZDOTDIR/.aliases
fpath+=( $HOME/.cache/antidote/belak/zsh-utils/history )
source $HOME/.cache/antidote/belak/zsh-utils/history/history.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( $HOME/.cache/antidote/romkatv/zsh-defer )
  source $HOME/.cache/antidote/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( $HOME/.cache/antidote/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source $HOME/.cache/antidote/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( $HOME/.cache/antidote/zsh-users/zsh-autosuggestions )
source $HOME/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( $HOME/.cache/antidote/zsh-users/zsh-history-substring-search )
source $HOME/.cache/antidote/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
