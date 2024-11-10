#zmodload zsh/zprof


# -- [[ ALIASES ]] -- 
source $ZDOTDIR/aliases.zsh

# -- [[ EXPORTS ]] 
export VISUAL="/usr/local/bin/nvim"
export EDITOR="/usr/bin/vim"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"


# manpage highlighting
# export LESS_TERMCAP_mb=$"\e[1;32m"
# export LESS_TERMCAP_md=$"\e[1;32m"
# export LESS_TERMCAP_me=$"\e[0m"
# export LESS_TERMCAP_se=$"\e[0m"
# export LESS_TERMCAP_so=$"\e[01;33m"
# export LESS_TERMCAP_ue=$"\e[0m"
# export LESS_TERMCAP_us=$"\e[1;4;31m"

#rust
fpath=(~/.cargo/bin $fpath)


source /usr/share/nvm/init-nvm.sh
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

 # wayland on firefox
 export MOZ_ENABLE_WAYLAND=1

 #PATH stuff
 export PATH=$PATH:/usr/games
 # golang
 export GOPATH=$HOME/go
 export PATH=$PATH:$GOPATH/bin
 export PATH=$PATH:/usr/local/go/bin
 export PATH=$HOME/.local/bin:$PATH
 export PATH=$HOME/.local/scripts:$PATH

function nvimconfig() {
  local oldpwd=$(pwd) # Save the current working directory
  cd $HOME/.config/nvim # Change to the nvim config directory
  nvim  # Open nvim in the current directory (which is now the nvim config directory)
  cd "$oldpwd" # Return to the original working directory after exiting nvim
}
function tmuxconfig() {
  local oldpwd=$(pwd) 
  cd $HOME/.config/tmux/
  nvim tmux.conf
  cd "$oldpwd"
}
function alacrittyconfig() {
  local oldpwd=$(pwd)
  cd $HOME/.config/alacritty/
  nvim . 
  cd "$oldpwd"
}


# CLI Tools
eval $(thefuck --alias fk)
bindkey -s ^f "tmux-sessionizer\n"

# functions
function ssh-lemon() {
    LEMONADE_PID_FILE="$HOME/.lemonade_pid"

    # Start Lemonade server if not running
    if ! pgrep -f "lemonade server" > /dev/null; then
        echo "Starting Lemonade server..."
        lemonade server > /dev/null 2>&1 &
        echo $! > "$LEMONADE_PID_FILE"
    else
        echo "Lemonade server is already running."
    fi

    # SSH into the remote machine
    ssh "$@"

    # Stop Lemonade server if it was started by this script
    if [ -f "$LEMONADE_PID_FILE" ]; then
        kill $(cat "$LEMONADE_PID_FILE")
        rm "$LEMONADE_PID_FILE"
        echo "Lemonade server stopped."
    fi
}

lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# PLUGINS 
# Additional completions
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# Auto suggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# bind ctrl+space to auto suggest accept
bindkey '^e' autosuggest-accept

# syntax highlighting
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


fpath+=${ZDOTDIR:-~}/.zsh_functions

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

#zprof
