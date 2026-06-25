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

Clone the repo into your home directory at ~/.dotfiles. It has git submodules
(the zsh plugins), so clone with `--recurse-submodules`:

```bash
git clone --recurse-submodules <repo-url> ~/.dotfiles
```

(Already cloned without them? Run `git submodule update --init --recursive`.)

Then, you can easily create symlinks for the files in this directory to their equivalent locations in the home directory using:

```bash
cd ~/.dotfiles
stow --dotfiles .
```

I also have a script to update local dotfiles. Assuming `~/.local/scripts` is in your path:

```sh
sync-dots
```

### How it Works

GNU Stow walks the directory hierarchy of the directory passed to stow and creates symlinks in the target directory to match the structure.

An important requirement is that the dotfiles directory must have the same structure as where the files would be placed in the home directory. To make this work with dotfiles, rename top-level directories in the .dotfiles folder with a dot- prefix, such as dot-config for .config. Running stow with the --dotfiles option will recognize these dot- prefixed directories and create symlinks to ~/.config, ~/.local, etc.

By default, stow assumes that the target directory is the parent directory of the one specified. Therefore, running:

```bash
stow --dotfiles -t ~ .
```

is equivalent to:

```sh
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
^/[^/]*\.md$
```

This will avoid linking the `.git` folder (**you should do this**), a folder called `misc`, and any `.md` files into your home directory.

> The `.md` pattern is anchored to **root level only** (`^/[^/]*\.md$`), not
> `^/.*\.md`. The unanchored version matches `.md` at *any* depth, which would
> silently skip the `.claude/CLAUDE.md` and `.codex/AGENTS.md` leaf symlinks
> (see "Global AI agent instructions" below). Keep it root-only.

**Note**, by creating this file, you override `stow`'s default ignore file behavior.

### Cleaning up the Symlinks

To delete the symlinks created by stow, use the -D option. For example, to remove the symlinks:

```sh
stow -D --dotfiles .
```

This will safely delete the symlinks created during setup without removing the actual files in `.dotfiles.`

## Global AI agent instructions

Tool-agnostic guidance that every AI coding agent (Claude Code, Codex) loads
globally - mainly: "a personal Obsidian vault lives at ~/vault, reach it via
the `obsidian` CLI, and never cross the ~/wault work boundary."

One canonical source, symlinked into both tools so editing one file updates
both:

```
misc/ai/AGENTS.md            <- canonical source (tracked; stow-IGNORED via misc)
.claude/CLAUDE.md  -> ../misc/ai/AGENTS.md   stows to ~/.claude/CLAUDE.md  (Claude Code)
.codex/AGENTS.md   -> ../misc/ai/AGENTS.md   stows to ~/.codex/AGENTS.md   (Codex)
```

To change the instructions, edit `misc/ai/AGENTS.md` only. The two leaf
symlinks are plain `.md` files, so the `.stow-local-ignore` `.md` rule must
stay root-only (see "Ignoring Files and Directories") or stow will skip them.
