# john's dotfiles

## Managing Dotfiles

Use [GNU Stow](https://www.gnu.org/software/stow/), a symlink farm manager.
> Essentially, it mirrors the structure of one directory into another by creating symbolic links back to the original files.

This is extremely useful with a directory full of config (dot) files that is managed by git and you want to send all of those config files to where they belong in the home directory.

## Installation

Installation varies on OS. If you're on Windows, good luck because idk. I believe stow should be easy to install via `brew` on Mac

**Debian/Ubuntu**

```bash
sudo apt-get update
sudo apt-get -y install stow
```

**Arch**

```bash
sudo pacman -S stow
```

## Basic Usage

I'm assuming you've cloned this repo into home, i.e. at '~/.dotilfes` or something.
We can easily create symlinks to the files in this directory to the equivalent locations in the home directory using:

```bash
stow .
```

To use stow, remove existing files otherwise it will error.

### How it Works

GNU Stow walks the directory hierarchy of the directory passed as the first parameter to the `stow` command and creates symlinks to those files in the equivalent locations in the target directory.

The important thing it that the dotfiles directory **must have the same structure** as where the files would be placed under the home directory. This means you will need to have the equivalent subdirectory structure in your dotfiles folder so that all symbolic links get created in place.

By Default, `stow` assumes that the target directory is the parent directory of the one that you specified.

This means that `stow .` is equivalent to:

```bash
stow --dir=~/.dotfiles --target=~/
# OR
stow -d ~/.dotfiles -t ~/
```

In case you want to change it :)

### Ignoring Files and Directories

By default, `stow` does a good job of ignoring common files and directories that you might not want to link back to your home directory.

However, for manual control, create a `.stow-local-ignore`. Each line of this file should be a string or regex, similar to a `.gitignore` file. For example:

```
\.git
misc
#Docs
^/.*\.md
```

This will avoid linking the `.git` folder (**you should do this**), a folder called `misc`, and any files ending in `.md` into your home directory.

**Note**, by creating this file, you override `stow`'s default ignore file behavior.

### Cleaning up the Symlinks

If you want to delete the symlinks, add an extra parameter, `-D`. For example, continuing the prior one and we want to delete those symlinks, run:

```bash
stow -D .
```

## Don't forget to `stow` every time you sync

If using `git` to store and commit config files to a repo, run `stow` each time you sync to **ensure** that any new config files get linked into the proper location.

The following script, `sync-dotfiles` will automate this whole process. It will stash the current changes to your dotfiles folder, pull any new changes from the remote repo, pop the stashed changes, and then run `stow .`

Consider keeping in a `bin` subfolder of your `~/.dotfiles` and add it to `PATH`.

```sh

#!/bin/sh

# Sync dotfiles repo and ensure that dotfiles are tangled correctly afterward

GREEN='\033[1;32m'
BLUE='\033[1;34m'
RED='\033[1;30m'
NC='\033[0m'

# Navigate to the directory of this script (generally ~/.dotfiles/.bin)
cd $(dirname $(readlink -f $0))
cd ..

echo -e "${BLUE}Stashing existing changes...${NC}"
stash_result=$(git stash push -m "sync-dotfiles: Before syncing dotfiles")
needs_pop=1
if [ "$stash_result" = "No local changes to save" ]; then
    needs_pop=0
fi

echo -e "${BLUE}Pulling updates from dotfiles repo...${NC}"
echo
git pull origin master
echo

if [[ $needs_pop -eq 1 ]]; then
    echo -e "${BLUE}Popping stashed changes...${NC}"
    echo
    git stash pop
fi

unmerged_files=$(git diff --name-only --diff-filter=U)
if [[ ! -z $unmerged_files ]]; then
   echo -e "${RED}The following files have merge conflicts after popping the stash:${NC}"
   echo
   printf %"s\n" $unmerged_files  # Ensure newlines are printed
else
   # Run stow to ensure all new dotfiles are linked
   stow .
fi
```
