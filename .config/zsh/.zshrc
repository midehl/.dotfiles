#zmodload zsh/zprof

source $ZDOTDIR/zsh_aliases.zsh

# -- [[ EXPORTS ]] 
export VISUAL="$(which nvim)"
export EDITOR="/usr/bin/vim"
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
 export PATH=$HOME/.local/bin:$PATH
 export PATH=$HOME/.local/scripts:$PATH

source /usr/share/nvm/init-nvm.sh

# -- [[ Zsh Options ]]
setopt autocd nomatch 
setopt interactive_comments
unsetopt BEEP # beeping is annoying
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v # enable Vi mode
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "/$HOME/.config/zsh/.zshrc"
autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall

source $ZDOTDIR/python.zsh

# CLI Tools
eval $(thefuck --alias fk)
bindkey -s ^f "tmux-sessionizer\n"
bindkey '^e' autosuggest-accept

# -- [[ PLUGIN Loading ]] -- 

source $ZDOTDIR/plugins/colored-manpages.zsh
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

#zprof
