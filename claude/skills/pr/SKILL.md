---
name: pr
description: Write or rewrite a GitHub PR description (and title) in Scott's house style. Use for "/pr", "write the PR description", "open a PR", or "fix up this PR body". Picks a recipe by PR type; never leaves template placeholders behind.
---

# /pr: PR description in Scott's style

Derived from PRs (2023-2025). The voice is a Slack message to a
teammate: first person, why before what, honest about what's rough, short.

## Workflow

1. **Gather** (don't ask for what you can look up):
   - `git log --oneline <base>..HEAD` and `git diff --stat <base>...HEAD`
   - `gh pr view --json number,title,body,url 2>/dev/null` (is there a PR already?)
   - `gh pr list --state all --search "<branch keywords>"` for sibling/previous PRs in a series
   - Issue/PR URLs in commit messages or branch name
   - The repo's `.github/pull_request_template.md`, if any. Its headers are the skeleton.
2. **Classify** the PR with `recipes.md` and pick one recipe. Ask only if it's genuinely
   ambiguous (e.g. refactor vs. feature phase).
3. **Ask for what you can't know**, in one message, only if the recipe needs it:
   where the bug was reported (Slack / Linear / issue), flag names, names of people
   who made a decision, what's intentionally left out.
4. **Draft** title + body to a scratch file. Follow the recipe and the rules below.
   Mark media the user must add as `[[ screenshot: <what to show> ]]` on its own line.
5. **Show the draft**, then on confirmation apply with
   `gh pr create --title ... --body-file ...` or `gh pr edit <n> --body-file ...`.
   Never push a body to GitHub without showing it first.

## Voice

- First person. "I" for decisions and digging, "we" for team/product intent.
- Contractions, plain words, medium sentences. Paragraphs of 1-3 sentences.
- Say why before what. Include the path: what was tried, what didn't work, what was
  decided and by whom ("after discussion with Shaqs", "Ivan renamed this in ...").
- Hedge honestly and specifically: "I'm not 100% on _why_", "this is still a little rough".
  Never fake confidence, never pad with confidence either.
- Light humor is fine, one emoji per paragraph max, at the end of a sentence
  (🙃 😅 🤔 🙌 ☝️ 💀). 🚨 or ❗ + bold for "don't merge yet" / real risk. None in headers.
- Backticks for every identifier, prop, file, flag. `_underscores_` for a single emphasized word.
- Link with bare URLs, one per line: prior PRs, the issue, permalinks to exact lines,
  the BE PR, the Slack thread. Screenshot a Slack thread inside `<details><summary>Slack context</summary>`.
- Refer to people by first name. CC with @handle when you need a decision from them.

## Content that belongs

- The source of the work: issue, Slack report, Helpscout/Sentry, BE PR, tracking issue.
- Root cause as a numbered chain for bugs ("The story is this: 1. ... 2. ...").
- What changed, as a numbered list by concern (2-6 items, nested bullets for nuance),
  then prose for the one or two tricky decisions, each under its own `###`.
- Rejected alternatives and why.
- Scope honesty: "This does not do X yet", "I did not touch Y", "no user-facing changes".
- Side changes, explicitly fenced off under "Also:" or "While I was in there".
- Reviewer guidance when it saves time: "go commit by commit", "safe to skip commits 2 & 3,
  bulk search-and-replace", "easier to read the final diff".
- Testing: numbered steps for a flow (flag name first), one sentence for a spot check
  ("Smoke test of X"), or "nothing user-facing" for refactors. Say how *you* tested if
  steps don't apply. Say plainly when you couldn't test.
- Next up / follow-ups with links to issues you opened. Open questions, addressed to someone.
- `### Changes to Owned Code`: `Team: <name>` + one-line directive ("this is for you",
  "ignore, just exporting a type"). Collapse to "All A&I" when single-team.

## Content that doesn't

- No file-by-file restating of the diff. No "Summary" / "Test plan" boilerplate headers.
- No checklists, no "N/A", no bold-label pseudo headers, no closing sign-off or thanks.
- No template residue: delete unused sections and every `<!-- -->` comment, `![Alt text](url-to-image.png)`,
  `- Closes #`, `Team:\n- Change`. (147 of 920 past PRs shipped with some. This is the rule to enforce.)
- No Mobile screenshot block unless the change is layout/mobile-specific.
- Don't explain standard codebase patterns. Assume the reader works here.
- Don't repeat the title as the first line. Start with the link/source or straight into context.
- Don't restate series context. Link the first PR of the series and state only the delta.

## Titles

- `Area: thing` or `` `Component`: thing `` (or `[Project] thing` for a long series).
  Examples: "Lead V2: Custom Object back references pt. 1", "`HTMLEditor`: fix link exiting",
  "[atoms reorg] Move icons", "Workflows: release tabbed modal".
- Sentence case, ~50 chars, no trailing period. Lowercase is fine for small stuff.
- Series: "part 2" / "pt. 3"; "Final" or "wraps up" for the last one; "redux" for a second attempt.
- Reverts keep GitHub's `Revert "..."` title.
- No conventional-commit prefixes (`fix:`, `feat:`). No ticket IDs in the title: they live in the
  branch name (Linear convention) and in Related Issues.

## Files

- `recipes.md`: skeleton per PR type. Pick exactly one.
- `examples.md`: real past descriptions, verbatim, to match tone against.
