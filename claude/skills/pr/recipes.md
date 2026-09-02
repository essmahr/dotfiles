# Recipes

Pick one. Section order follows the repo template (Related Issues, Background,
Description, Changes to Owned Code, Screenshots, Testing Instructions, Additional
Notes). Drop any section the recipe marks optional if you have nothing real to put
in it. Never leave a header with only a placeholder under it.

Related Issues vocabulary (bare URLs, one per line, bullets optional):
`Closes`, `Part of <tracking issue>`, `Follows <prev PR>`, `Followup to`, `Stacks on`
(literally branched off), `Prereq for`, `FE half of <BE PR>`, `Reapplies`, `Related to`.
Linear tickets go here too, as `Closes FEP-123` or the issue URL, never in the title.

Size rule: 1-2 files and one idea? Use **Tiny**. Otherwise use the type recipe.

---

## Tiny (1-2 files, one idea)

No template. Two to four sentences: what and why, optional screenshot inline.
Name the source if there was one ("Reported via Slack:", "Fixes a miss from <PR>").
Say if it's a stopgap: "patching this quickly to keep the error out of prod".

```
<one sentence: what this does and why>

<optional: "Fixes:" + screenshot, or "Reported via Slack:" + screenshot>

<optional one sentence: caveat / what's next>
```

## Revert

GitHub's default line plus one sentence of reason. If it sweeps up other PRs, list them.

```
Reverts closeio/close-ui#NNNN

<one sentence: what broke, "reverting for now">
<optional: "Also reverts <PR> and <PR> which got caught up in the changes.">
```

## Bugfix

The description is the root cause. Background holds the story; Description holds the fix.
Skip Background if the cause fits in one paragraph.

```
## Related Issues
- Closes <issue>            (or "Reported via Slack:" + screenshot, or Helpscout/Sentry link)
- Followup to <PR>          (if self-inflicted, say so: "Fixes a miss from <PR>")

## Background                (optional)
<what the user saw, screenshot of the bug>
<root cause as prose or a numbered chain: "The story is this: 1. ... 2. ... 3.">

## Description
<the fix in 1-3 sentences. Why this fix and not the other one.>
<optional: "This fix is temporary, I'll follow up with ..." or side changes under "Also:">

### Changes to Owned Code   (only if another team is tagged)
Team: <name>
- <one line>

## Screenshots               (optional)
<details><summary>Desktop</summary>

### Before
[[ screenshot: broken state ]]

### After
[[ screenshot: fixed state ]]

</details>

## Testing Instructions
<repro as steps, or "On master, X. On this branch, Y." Or: why screenshots suffice.>
```

## Feature, standalone

```
## Related Issues
- Closes <issue>
- FE half of <BE PR>        (if paired)

## Background                (optional: product decision, Slack/Figma link, constraint)

## Description
<one sentence: "This adds/wires up ...">
1. <change, by concern>
2. <change>
   * <nuance>
3. <change>

### <the one tricky decision>   (optional, one or two of these)
<why, alternatives considered>

### Changes to Owned Code
Team: <name>
- <one line directive>

## Screenshots
<details><summary>Desktop</summary>

### <state or scenario>
[[ screenshot / video: ... ]]

</details>

## Testing Instructions
1. Enable the `FLAG_NAME` flag      (flag first, if any)
2. <concrete page / action>
3. <what to observe>

## Additional Notes           (optional: limitations found while testing, open questions)
```

## Feature, phase N of a series

Same as standalone, but: link the tracking issue and previous PR, repeat one sentence
of context at most, state what is *not* done yet, end with Next up.

```
## Related Issues
- Part of <tracking issue>
- Follows <previous PR>
- Prereq for <next issue>   (optional)

## Description
<one sentence placing this part: "Following <PR>, this actually adds ...">
1. ...
2. ...

<"This is not wired into the UI yet" / "no user-facing changes yet" if true>

### Rough bits              (for early / collaborative phases)
* <what's knowingly broken or missing>

### Changes to Owned Code
...

## Screenshots
...

## Testing Instructions
<steps, or "Same as <previous PR>">

## Next up
* <concrete item>
* <concrete item>
```

## Mechanical migration / refactor (incl. series batches)

Short. Scope statement, what moved, behavior callout, reviewer guidance, smoke test.
Series batches reuse the same Description with only the batch contents changing
("Another batch!", "More of the same, see <first PR>").

```
## Related Issues
- Part of <tracking issue / ADR>
- Follows <previous batch>

## Background                (first PR of the series only)
<goal in two sentences>

## Description
<one sentence of scope: "This moves X into Y as per the proposal.">
* <what moved / renamed>
* <anything behavioral, called out explicitly>
* <"I did not ..." scope cuts>

<reviewer guidance: "go commit by commit" or "safe to skip commits 2 & 3, bulk search-and-replace"
 or "easier to read the final diff">

### Changes to Owned Code
<"All teams are tagged, but this is a DS guild PR" / "If you're tagged I just tweaked one of your stories">

## Screenshots
No user-facing changes.

## Testing Instructions
Smoke test of <area>.          (or "compare with prod storybook", "nothing user-facing")

## Additional Notes           (optional: what the next batch will do)
```

## Flag release / unflag

```
🚨 Don't merge until we want to release!    (remove once ready)

## Related Issues
- Closes <issue> (one per feature being released)

## Description
This removes the `FLAG_NAME` flag (and `OTHER_FLAG`).
<list any un-flaggable tweaks that ride along>

### Changes to Owned Code
...

## Screenshots
<details><summary>Desktop</summary>
<one screenshot per released surface, `###` captioned>
</details>

## Testing Instructions
1. With _no feature flags_, <surface> should function as before
2. <flag-specific behavior that should now be default>

## Additional Notes
<"I'll follow up with the BE PR to remove the flag">

> [!NOTE]
> **User-Facing Change**
>
> <one user-readable sentence>       (only when the repo template has this block and users will notice)
```

## Polish / UX tweaks

```
## Related Issues
- Stacks on <PR> / Most of <issue>

## Description
<"Multiple self-explanatory UI tweaks." or a short numbered list>

## Screenshots
<details><summary>Desktop</summary>

### <tweak name>
[[ screenshot ]]

</details>

## Testing Instructions       (optional; often "surface level, see screenshots")
```

## Deps / tooling / tests / docs

Usually no template. One paragraph: why, what, what broke and how it was handled.
Call out big bumps in bold: "**This is a huge bump**, but we only use it for ...".
For a per-package upgrade PR, one `##` per package with 1-3 bullets.

## WIP / experiment

Body can be one line. If reviewers will look: what it proves, what's knowingly broken
("### Rough bits"), what you want feedback on. Title prefixed `[WIP]`.
