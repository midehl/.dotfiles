#zmodload zsh/zprof

# -- [[ EXPORTS ]] 
export VISUAL="$(which nvim)"
export EDITOR="$(which nvim)"
export GOPATH=$HOME/go
export MOZ_ENABLE_WAYLAND=1
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# -- [[ PATH Additions ]]
 export PATH=$PATH:/usr/games
 export PATH=$PATH:$GOPATH/bin
 export PATH=$PATH:/usr/local/go/bin
 export PATH=$HOME/.local/scripts:$PATH
 export PATH=$HOME/.local/bin:$PATH

# -- [[ Zsh Options ]]
setopt autocd nomatch 
setopt interactive_comments
setopt hist_ignore_dups  # don't record duplicate commands in history
setopt share_history     # share command history across all sessions
setopt hist_expire_dups_first # remove older duplicates from the history
setopt hist_find_no_dups # ignore duplicates when searching in history
setopt correct # offer spell checking
unsetopt BEEP # beeping is annoying
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v # enable Vi mode
# The following lines were added by compinstall
zstyle :compinstall filename "/$HOME/.config/zsh/.zshrc"
autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall

eval "$(/usr/bin/mise activate zsh)"
#source $ZDOTDIR/python.zsh

# -- [[ PLUGINS ]] -- 
source $ZDOTDIR/plugins/colored-manpages.zsh
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions

# -- [[ Configure Prompt ]]
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

source $ZDOTDIR/aliases.zsh

# CLI Tools
eval $(thefuck --alias fk)
bindkey -s ^f "tmux-sessionizer\n"
bindkey '^e' autosuggest-accept

#zprof
