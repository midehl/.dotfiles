export ZDOTDIR=$HOME/.config/zsh

# last30days skill: save research briefs into the vault raw-source layer, not ~/Documents
export LAST30DAYS_MEMORY_DIR="$HOME/vault/_extras/sources/last30days"
# last30days engine needs Python 3.12+; mise-managed 3.12 (minor-version symlink survives patch upgrades)
export LAST30DAYS_PYTHON="$HOME/.local/share/mise/installs/python/3.12/bin/python3"
