# Claude Code skills

Each subdirectory is one skill: `<name>/SKILL.md` plus any supporting files.

`setup.sh` symlinks every skill here into `~/.claude/skills/<name>` and prunes
symlinks pointing at skills that no longer exist. Real directories in
`~/.claude/skills` are left alone, so local-only skills can live next to these.
