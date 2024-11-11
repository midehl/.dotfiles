# MISC ------------------------------
alias notes="cd $HOME/Notes && vim"
alias notescd="cd $HOME/Notes"
alias c=clear
alias lzd='lazydocker'
alias t=tmux
alias ta='tmux attach -t'
alias d=docker
alias rm=trash-put

# GIT ------------------------------
# Status
alias ff='gpr && git pull --ff-only'
alias gs='git status'
alias gl='git log --all --graph --format=oneline'
alias gd='git diff'
alias gds='git diff --staged'
alias grs='git restore --staged'
# Committing
alias gad='git add '
alias gal='git add .'
alias gcm='git commit -m'
# Push/Pull
alias gp='git pull'
alias gP='git push' # capitalize push for safety
alias gpf='git push --force-with-lease'
alias gpr='git pull --rebase' # keep cleaner commit history
# GIT Branch
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gpr='git remote prune origin'
alias gm='git merge'
# Other
alias gstash='git stash'

# Go places lol------------------------------
alias dotfiles="cd $HOME/.dotfiles/"
alias zshconfig="nvim $HOME/.config/zsh/.zshrc"
alias zshup="source $HOME/.config/zsh/.zshrc"
alias sshconfig="nvim $HOME/.ssh/config"
alias swayconfig="nvim $HOME/.config/sway/config"
alias cat="bat --paging=never"
alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias vim=nvim


# Exa/LS------------------------------
alias ls='exa'                                                          # ls
alias l='exa -lbF --git'                                                # list, size, type, git
alias ll='exa -lbGF --git'                                              # long list
alias llm='exa -lbGd --git --sort=modified'                             # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git'                 # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git'                # all list
# specialty views
alias lS='exa -1'                                                       # one column, just names
alias lt='exa --tree --level=3'                                         # tree
