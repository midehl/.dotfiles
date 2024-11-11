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

# some useful options (man zshoptions)
setopt autocd nomatch 
setopt interactive_comments
# BEEPING IS ANNOYING
unsetopt BEEP

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "/$HOME/.config/zsh/.zshrc"

autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall

 # >>> conda initialize >>>
 # !! Contents within this block are managed by 'conda init' !!
 __conda_setup="$("$HOME/miniconda3/bin/conda" "shell.zsh" "hook" 2> /dev/null)"
 if [ $? -eq 0 ]; then
     eval "$__conda_setup"
 else
     if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
         . "$HOME/miniconda3/etc/profile.d/conda.sh"
     else
         export PATH="$HOME/miniconda3/bin:$PATH"
     fi
 fi
 unset __conda_setup
 
 if [ -f "$HOME/miniconda3/etc/profile.d/mamba.sh" ]; then
     . "$HOME/miniconda3/etc/profile.d/mamba.sh"
 fi
 # <<< conda initialize <<<

export PYENV_ROOT=/home/midel/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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
