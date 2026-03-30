# dot-files

This repo is managed with [GNU Stow](https://www.gnu.org/software/stow/). Running `stow .` from the repo root symlinks everything into `$HOME`, mirroring the directory structure.

## How Stow Works Here

- Files and directories at the top level of the repo map to `~/` via symlinks.
- **Exception — `.claude/`:** Stow symlinks individual files inside `.claude/` rather than the directory itself (since `~/.claude/` already exists with other content). Add new Claude config files directly inside `.claude/` and re-run stow.
- **`bin/`** maps to `~/bin/` — each script gets its own symlink.

## Making Changes

### Edit an existing file
Just edit it in the repo. The symlink means the change is live immediately — no re-stow needed.

### Add a new dotfile or config
1. Place the file at the correct path inside the repo (e.g. `.config/foo/bar.toml` → symlinks to `~/.config/foo/bar.toml`).
2. Run `stow .` from the repo root to create the new symlink.

### Add a new bin script
1. Add the script to `bin/`.
2. Make it executable: `chmod +x bin/your-script`.
3. Run `stow .` to symlink it into `~/bin/`.

### Add a new Claude skill
1. Create `dot-files/.claude/skills/<skill-name>/SKILL.md`.
2. No re-stow needed — the `skills/` directory itself is already symlinked.

### Remove a file
1. Delete it from the repo.
2. Run `stow -D . && stow .` to refresh symlinks and remove the stale one.

## Verify symlinks

```bash
stow --simulate .   # dry run — shows what would change without touching the filesystem
```
