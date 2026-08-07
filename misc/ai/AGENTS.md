# Global agent instructions

Tool-agnostic guidance loaded by every AI coding session (Claude Code via
`~/.claude/CLAUDE.md`, Codex via `~/.codex/AGENTS.md`). Keep it lean.

## Dotfiles (~/.dotfiles)

New user-level configs, scripts, or plugin files belong in `~/.dotfiles`
(a git repo managed with GNU Stow, mirroring $HOME), not loose in the home
directory - so they are tracked. Create the file under the mirrored path,
symlink it into place stow-style, and check `.gitignore` (some trees like
`.local/share/*` are ignored and need a whitelist entry). Commit after
adding. Only truly machine-local or throwaway files skip the repo.

## Personal knowledge vault (~/vault)

A personal Obsidian knowledge/thinking vault lives at `~/vault`. When a task
involves saving, capturing, or recalling personal notes, research, or journal
entries, use it - even from a coding session in `~/repos`.

- Mutate the vault through the `obsidian` CLI wherever it can express the
  edit (e.g. `obsidian create`, `obsidian append`, `obsidian daily:append`,
  `obsidian property:set`). It works from any directory and uses Obsidian's
  own APIs. When the CLI falls short (in-body rewording, replacing a line),
  direct file edits are fine - the watcher reindexes. Never raw-edit
  frontmatter/links/tasks the CLI can handle.
- Read vault content with `obsidian search` / `obsidian read`, or add `~/vault`
  as a working directory when you need to grep across it.
- Before any non-trivial vault work, read `~/vault/AGENTS.md` - the full
  contract (frontmatter schema, folder lifecycle, the review gate). Do not
  guess at the vault's conventions.
- The vault's own skills / slash-commands are vault-scoped (they live in
  `~/vault/_extras/skills/`). From other directories, drive the vault through
  the `obsidian` CLI directly rather than expecting those commands.
