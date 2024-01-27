# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# EXPORTS
export EDITOR="vim"
export VISUAL="vim"
export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
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



 # PATH stuff
 export PATH=$PATH:/usr/games

 # golang
 export GOPATH=$HOME/go
 export PATH=$PATH:$GOPATH/bin
 export PATH=$PATH:/usr/local/go/bin
 export PATH=$PATH:$HOME/.local/bin
 # script for syncing dotfiles
 export PATH=$PATH:$HOME/.dotfiles/bin


# ALIASES 
alias zshconfig="vim $HOME/.config/zsh/.zshrc"
alias cat="bat --paging=never"


# CLI Tools
eval $(thefuck --alias)


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
