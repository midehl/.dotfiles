# Re-stowing a machine that was stowed before --no-folding (2026-08)

For any machine stowed before commit "stow hygiene" (Aug 2026): old stow runs
folded some dirs (a dir symlink into this repo instead of per-file links).
Foreign installer files may have been written *inside this repo's working tree*
through those folds. Fix, in order:

1. `stow --version` must be >= 2.4.0 (`--dotfiles --no-folding` is broken
   before that). Upgrade first if not.
2. `git -C ~/.dotfiles status --porcelain` — every untracked file is a foreign
   file that arrived through a fold. `mv` each one back to the same path under
   real `$HOME` (e.g. repo `.local/share/applications/Foo.desktop` ->
   `~/.local/share/applications/Foo.desktop`). Tree must be clean before step 3.
3. `cd ~/.dotfiles && stow -Rv --dotfiles --no-folding -t ~ .`
   On CONFLICT: back up / remove the pre-existing file in `$HOME`, re-run.
   NEVER use `--adopt` — it pulls the machine's file into the repo.
4. Verify no dir symlinks remain: `find ~/.local ~/.config -maxdepth 3 -type l \
   -lname '*dotfiles*' -exec test -d {} \; -print` must output nothing.
