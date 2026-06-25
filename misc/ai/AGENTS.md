# Global agent instructions

Tool-agnostic guidance loaded by every AI coding session (Claude Code via
`~/.claude/CLAUDE.md`, Codex via `~/.codex/AGENTS.md`). Keep it lean.

## Personal knowledge vault (~/vault)

A personal Obsidian knowledge/thinking vault lives at `~/vault`. When a task
involves saving, capturing, or recalling personal notes, research, or journal
entries, use it - even from a coding session in `~/repos`.

- Mutate the vault ONLY through the `obsidian` CLI (e.g. `obsidian create`,
  `obsidian append`, `obsidian daily:append`, `obsidian property:set`). It
  works from any directory and uses Obsidian's own APIs. Never raw-write files
  under `~/vault` - that desyncs Obsidian's metadata cache.
- Read vault content with `obsidian search` / `obsidian read`, or add `~/vault`
  as a working directory when you need to grep across it.
- Before any non-trivial vault work, read `~/vault/AGENTS.md` - the full
  contract (frontmatter schema, folder lifecycle, the review gate). Do not
  guess at the vault's conventions.
- The vault's own skills / slash-commands are vault-scoped (they live in
  `~/vault/_extras/skills/`). From other directories, drive the vault through
  the `obsidian` CLI directly rather than expecting those commands.

## Hard boundary

`~/wault` is a SEPARATE Walmart work vault containing classified / internal
content. Never copy anything out of `~/wault` into `~/vault`, into `~/repos`,
or anywhere public. Public/personal material may flow into `~/vault`;
classified material must never cross out of `~/wault`.
