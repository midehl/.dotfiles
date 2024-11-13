# MISC ------------------------------
alias c=clear
alias t=tmux
alias ta='tmux attach'
alias rm=trash-put
alias cat="bat --paging=never"
alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias vim=nvim
alias d=docker
function dclear() {
  docker ps -a -q | xargs docker kill -f
  docker ps -a -q | xargs docker rm -f
  docker images | awk '{print $3}' | xargs docker rmi -f
  docker volume prune -f
}
function take() {
  mkdir -p "$1"
  cd "$1"
}
alias notes="cd $HOME/Notes && nvim"
alias notescd="cd $HOME/Notes"
function note() {
  echo "date: $(date)" >> $HOME/Notes/atlas/quicklist.md
  echo "$@" >> $HOME/Notes/atlas/quicklist.md
  echo "" >> $HOME/Notes/atlas/quicklist.md
}
alias show_notes="bat $HOME/Notes/atlas/quicklist.md --paging=never"

# GIT ------------------------------
# Status
#alias ff='gpr && git pull --ff-only'
function ff() {
  # prune remote-tracking branches that have been deleted on the remote
  git fetch -p

  # avoid deletion on certain (common) branches
  # rare case bc these should (assumingly) always have a remote
  local protected_branches=("main" "master" "develop" "staging")
  local exclude_pattern=$(printf "|%s" "${protected_branches[@]}")
  exclude_pattern=${exclude_pattern:1}

  # list local branches with no upstream and exclude protected branches
  local branches_to_delete=$(git branch -vv | awk '/: gone]/{print $1}' | grep -vE "^(${exclude_pattern})$")
  if [[ -n "$branches_to_delete" ]]; then
    echo "The following branches have no upstream and will be deleted:"
    echo "$branches_to_delete"
    # Note: Confirmation is Zsh syntax and may not work on other shells
    echo -n "Are you sure you want to delete these branches? (y/N) "
    read confirmation
    if [[ "$confirmation" =~ ^[Yy]$ ]]; then
      echo "$branches_to_delete" | xargs -n 1 git branch -d
    else
      echo "Branch deletion aborted."
    fi
  fi
}
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
alias gprb='git pull --rebase' # keep cleaner commit history
# GIT Branch
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gpr='git remote prune origin'
alias gm='git merge'
# Other
alias gstash='git stash'

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

# Configs------------------------------
alias dotfiles="cd $HOME/.dotfiles/"
alias zshconfig="nvim $HOME/.config/zsh/.zshrc"
alias zshup="source $HOME/.config/zsh/.zshrc"
alias zalias="nvim $HOME/.config/zsh/aliases.zsh"
alias sshconfig="nvim $HOME/.ssh/config"
alias nvimconfig="nvim $HOME/.config/nvim"
alias tmuxconfig="nvim $HOME/.config/tmux"
alias alacrittyconfig="nvim $HOME/.config/alacritty"

# Lazy------------------------------
alias lzd='lazydocker'
function gg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
