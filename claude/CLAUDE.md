## Communication and Tone

- No flattery.
- Ask for clarification if instructions are not specific enough.
- Be extremely concise. Write in short, complete sentences: one idea each, specific nouns, active voice. Cut filler, not grammar.
- Criticism is welcome. Suggest simpler or alternate approaches.
- Plain words. No copula substitutes ("serves as", "marks", "represents"), no synonym rotation, no invented jargon or metaphors ("echo", "seam", "carries", "rides along"). Use terms already in use.
- Avoid em-dashes: use a colon, or split the sentence.

## Writing Code

- Prefer early returns and guards over `else` statements, including ternaries in a return position: `if (!cond) return a; return b;`, not `return cond ? b : a;`.
- Test hooks through the component that uses them. Add a hook-only `renderHook` spec only when the hook has no UI consumer.

## Code Comments

- Be frugal. Prefer self-documenting code and descriptive names. Inline comments are a last resort, for the non-obvious "why". If one needs 3+ causal links, cut it to ~2 sentences or promote it to a docblock.
- Docblock a function only if it holds complex logic (>~10 lines) and its name cannot speak for itself. Always use `/** */` JSDoc style.
- Lead a docblock with the plain-English "what" in one sentence (also on constants and types). The "why" goes after, in its own paragraph. One idea per paragraph, blank lines between.
- Write casually, like explaining to a teammate. Contractions and "we" are fine.
- Cut what the code makes self-evident, settled decisions ("intentionally X, not Y"), and planning residue ("accepted trade-off", "Phase 4"). Removal notes should state the observable condition ("remove once wrapper migration ships") or a public ticket ("remove as part of CRM-67").
- Comments must read without PR context: name concrete components and queries, no unanchored pronouns.
- Length is fine when every line is a distinct fact: per-option bullets, diff summaries, test constants with arithmetic. Comparing to an alternative implementation is OK for a genuine gotcha, kept to 1-2 lines.


## Git

- Use short casual commit messages (no `feat:` prefixes)
- Single-line commit messages. Use multiline only for complex or non-obvious changes
- Commit message format: imperative mood, lowercase, no trailing period — `add CheckboxInput primitive`, not `Added CheckboxInput Primitive.`
- prefer small, atomic commits
- Atomic commit units: separate commits for renames/moves (no logic changes), refactors (no behavior changes), test migrations, and lint-only passes
- Always tend towards human-readable git history. For example, if a PR both renames and updates a file, rename the file first in its own commit (`git mv`) and update after.
- Edit PR descriptions from the live body (`gh pr view <n> --json body`), never from a local file. If the text to replace isn't there, stop and ask.
- Once a PR is in review, never force push. Additive commits are fine when they fix or adjust the PR's existing scope; anything that widens or pivots it goes in a stacked PR.


## Plan mode

- Make the plan extremely concise.
- At the end of each plan, give me a list of unresolved questions to answer, if any.


## Memory

- Do not write to auto-memory unless I say "remember this".
- When I correct you, don't save it. At the end of the task, list the
  corrections and propose a home for each (`~/.claude/CLAUDE.md`,
  `.agents/rules/`, `CLAUDE.local.md`, or nowhere). I decide.
- A recalled memory that conflicts with CLAUDE.md or the repo is wrong.
  Follow CLAUDE.md and flag the memory.
