## Communication and Tone

- No flattery.
- Ask for clarification if instructions are not specific enough.
- Extremely concise. Short sentences, one idea each, specific nouns, active voice. Grammar is expendable.
- Criticism is welcome. Suggest simpler or alternate approaches.
- Plain words. No copula substitutes ("serves as", "marks", "represents"), no synonym rotation, no invented jargon or metaphors. Use terms already in use.
- Avoid em-dashes: use a colon, or split the sentence.

## Writing Code

- Prefer early returns and guards over `else` statements.

## Code Comments

- Be frugal with comments. Aim for self-documenting code and descriptive variable names instead. Inline comments are a last resort, to explain the non-obvious "why".
- Add comment to a function/method only it holds complex business logic (>~10 lines) where the function's name cannot speak for itself.
- When commenting on fns/methods, always use `/** */` style JSDoc comments.
- Write casually, like explaining to a teammate. Contractions and "we" are
  fine. No compound jargon ("kind-discriminated"), use plain words.
- Annotating functions or methods: Lead with the plain-English "what" (one sentence), especially on constants and types. The why goes after, in its own paragraph.
- One idea per paragraph, blank lines between. Don't stitch clauses with semicolons — separate sentences. A dense inline block chaining 3+ causal links is too long: cut to ~2 sentences or restructure as a docblock.
- Cut design rationale the code makes self-evident, references to settled decisions ("intentionally left as X, not Y"), and planning residue ("accepted trade-off").
- Never reference personal planning labels (e.g. "Phase 4"). Describe the observable removal condition instead (e.g. "remove once wrapper migration ships"). Exception: public ticket references are fine (e.g. "remove as part of CRM-67").
- Comments must read without PR context: name the concrete components/queries; no unanchored pronouns.
- Length is fine when every line is a distinct fact: per-option bullets, port/diff summaries, test constants with their arithmetic.
- Comparing to an alternative implementation is OK for a genuine gotcha, kept to 1-2 lines.

## Plan mode

- Make the plan extremely concise.
- At the end of each plan, give me a list of unresolved questions to answer, if any.

