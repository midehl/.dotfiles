#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -- [[ EXPORTS ]] 
export VISUAL="/usr/local/bin/nvim"
export EDITOR="/usr/bin/vim"

# fzf setup
function fzf() { 
  ( # run in subshell to not pollute top level shell environment
    source $HOME/.config/fzf/
    $(whence -p fzf) "$@"
  )
}

# manpage highlighting
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

#rust
source "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"     # this loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"      # this loads nvm bash_completion
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
zstyle :compinstall filename '/home/john/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

 # >>> conda initialize >>>
 # !! Contents within this block are managed by 'conda init' !!
 __conda_setup="$('/home/john/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
 if [ $? -eq 0 ]; then
     eval "$__conda_setup"
 else
     if [ -f "/home/john/miniconda3/etc/profile.d/conda.sh" ]; then
         . "/home/john/miniconda3/etc/profile.d/conda.sh"
     else
         export PATH="/home/john/miniconda3/bin:$PATH"
     fi
 fi
 unset __conda_setup
 
 if [ -f "/home/john/miniconda3/etc/profile.d/mamba.sh" ]; then
     . "/home/john/miniconda3/etc/profile.d/mamba.sh"
 fi
 # <<< conda initialize <<<

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

 # wayland on firefox
 export MOZ_ENABLE_WAYLAND=1

 # PATH stuff
 export PATH=$PATH:/usr/games
 # golang
 export GOPATH=$HOME/go
 export PATH=$PATH:$GOPATH/bin
 export PATH=$PATH:/usr/local/go/bin
 export PATH=$HOME/.local/bin:$PATH
 export PATH=$HOME/.local//scripts:$PATH

# -- [[ ALIASES ]] --

# lol lazy asl
alias gs='git status'
alias gd='git diff'
alias gad='git add '
alias gal='git add .'
alias gcm='git commit -m'
alias gp='git pull'
alias gpr='git pull --rebase' # keep cleaner commit history
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gstash='git stash'
alias gl='git log'
alias gip='git push'

alias dotfiles='cd $HOME/.dotfiles/'
alias zshconfig="nvim $HOME/.config/zsh/.zshrc"
alias sshconfig="nvim $HOME/.ssh/config"
alias swayconfig="nvim $HOME/.config/sway/config"
alias cat="bat --paging=never"
alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias vim=nvim
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

# Exa/LS aliases
alias ls='exa'                                                          # ls
alias l='exa -lbF --git'                                                # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGd --git --sort=modified'                            # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

# specialty views
alias lS='exa -1'                                                       # one column, just names
alias lt='exa --tree --level=2'                                         # tree

# CLI Tools
eval $(thefuck --alias)
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

# PLUGINS 
# Additional completions
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# Auto suggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# bind ctrl+space to auto suggest accept
bindkey '^ ' autosuggest-accept

# syntax highlighting
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# themes
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions

#zprof
