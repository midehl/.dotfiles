
# -- [[ ALIASES ]] --

alias notes="cd $HOME/Notes && vim"
alias notescd="cd $HOME/Notes"
alias c=clear
alias lzd='lazydocker'


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
alias gP='git push' # capitalize push for safety

alias dotfiles="cd $HOME/.dotfiles/"
alias zshconfig="nvim $HOME/.config/zsh/.zshrc"
alias zshup="source $HOME/.config/zsh/.zshrc"
alias sshconfig="nvim $HOME/.ssh/config"
alias swayconfig="nvim $HOME/.config/sway/config"
alias cat="bat --paging=never"
alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias vim=nvim


# Exa/LS aliases
alias ls='exa'                                                          # ls
alias l='exa -lbF --git'                                                # list, size, type, git
alias ll='exa -lbGF --git'                                              # long list
alias llm='exa -lbGd --git --sort=modified'                             # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git'                 # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git'                # all list
# specialty views
alias lS='exa -1'                                                       # one column, just names
alias lt='exa --tree --level=3'                                         # tree
