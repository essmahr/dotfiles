---
name: refix
description: Amend a previous commit cleanly using git fixup + autosquash rebase
argument-hint: [commit-hash] <description-of-change>
allowed-tools: Read, Edit, Glob, Grep, Bash(command git:*)
---

Fix a previous commit by applying a fixup and rebasing it in cleanly.

## Parsing Arguments

`$ARGUMENTS` can be:
- `<hash> <change description>` — first token is 7–40 hex chars
- `<change description>` — no hash, infer target commit

**If `$ARGUMENTS` is empty:**
1. Run `command git diff` to check for unstaged changes.
2. If there are unstaged changes, use them as the target change. Skip to **Making the Change** — the files are already modified, so skip step 1–3 (just format/lint, stage, and rebase). Infer the target commit from the changed files using `command git log --oneline -10`.
3. If there are **no** unstaged changes, stop and ask the user:
   > What change do you want to make, and which commit should it fix? You can provide a description alone (I'll find the right commit) or a commit hash + description.

   Only continue once arguments are provided.

If no hash provided, run `command git log --oneline -10` and identify the most
relevant commit based on the description (by commit message, files touched, etc.).
Explain which commit you're targeting and why before making changes.

## Making the Change

Use the project's format/lint commands if project context already names them.
Don't go hunting through config files; if none are known, skip the lint step.

1. Read the original commit message: `command git show --format="%B" --no-patch <target-hash>`
2. Read the relevant files and make the necessary edits
3. Run format and lint on only the changed files. Pipe output through `tail -20`.
4. Stage only the changed files explicitly (never `git add .`)
   - `command git add <file1> <file2> ...`

## Committing and Rebasing

Evaluate whether the original commit message is still accurate:
- Does it reference any variable, function, or file names that the fixup renamed?
- Does the stated intent still match the final result?

**Message is still accurate:**
```bash
command git commit --fixup=<target-hash>
GIT_SEQUENCE_EDITOR=true command git rebase -i --autosquash <target-hash>~1
```

**Message needs updating:**
```bash
msg=$(mktemp)
printf 'amend! %s\n\n%s\n' "$(command git show -s --format=%s <target-hash>)" "new commit message" > "$msg"
GIT_EDITOR="cp $msg" command git commit --fixup=amend:<target-hash>
GIT_SEQUENCE_EDITOR=true GIT_EDITOR=true command git rebase -i --autosquash <target-hash>~1
```

`--fixup=amend:` creates an `amend!` commit whose body replaces the original
message during autosquash. `-m` and `-F` are rejected with `--fixup`, so the
message goes in via `GIT_EDITOR`. The file must keep the `amend! <original subject>`
first line: autosquash matches on it, and `cp` replaces the whole file. `GIT_EDITOR=true`
on the rebase accepts the new message without opening an editor.

If the rebase exits non-zero (conflict), enter a resolution loop:

1. `command git status` — identify conflicted files
2. Read each conflicted file — understand both sides of the conflict markers
3. Resolve: pick the version that correctly incorporates both the original commit's
   intent and the fixup's intent (you know both, so apply judgment)
4. Re-run project format/lint on resolved files (pipe through `tail -20`)
5. `command git add <resolved-files>`
6. `command git rebase --continue` (with `GIT_EDITOR=true` to skip commit message prompts)
7. Repeat until rebase completes or an unresolvable conflict is hit
8. If truly unresolvable, `command git rebase --abort`, explain clearly, and stop

After a successful rebase:
1. Confirm with `command git log --oneline -5` that history is clean.
2. If a backup branch was created before the rebase, delete it now: `command git branch -D <backup-branch>`

## Notes
- Use `command git` prefix for all git commands
- Never use `git add .` or `-A`
