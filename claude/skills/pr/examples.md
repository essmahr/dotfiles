# Examples

Real close-ui PR descriptions, verbatim except for stripped template comments and
image markup shortened to `[[ image ]]`. Match tone and shape against these.

## Tiny: #20601 "fix missing `ref` arg on `InsertTemplateDataButton`"

Fixes:

[[ image: TS error ]]

It seems that the forwardRef was maybe never needed here if we weren't actually passing the ref through, but forwarding refs on button-like components never hurts.

## Tiny: #17026 "Feature Flag modal: autofocus search input"

I want to start searching for flags as soon as I open this thing!

I also fixed the bottom corners of the modal... it seems we had an edge case here of a modal with no footer but scrollable content.

[[ image ]]

## Revert: #11346 "Revert "Ensure theme CSS files are valid CSS (#11244)""

This reverts commit 8bd4a6acf85edb7a26f78404a3ddcbf325463f7f.

There are some cases where theme values are not applying, reverting for now.

## Bugfix: #14812 "Subscription Management modal: ensure modal opens with fresh data"

## Related Issues

- Closes https://github.com/closeio/close-ui/issues/14646

## Description

Apollo's default fetch policy is `cache-first` which was the main cause of the issue here. Because subscriptions are updated via REST otherwise, the result of the contact subscriptions query was not staying in sync with the latest BE state. So, switching to cache-and-network resolves the issue, each time the modal opens it will re-fetch contact subscriptions.

I've added a `nextFetchPolicy` because without it, the modal was going into unwanted loading states as fresh data was being fetched (say, after resuming a paused subscription)

As part of this PR I've also attempted to make the modal's `contact` prop optional. Initially I thought that this was part of the fix (ensuring that contact ID switched to `undefined` when the modal was closed) but it isn't! I left that code in because it removes some conditional rendering of modals, letting the modal 100% rely on the `visible` prop which is the pattern we're trying to stick with.

## Screenshots

<details>
  <summary>Desktop</summary>

[[ video ]]

</details>

## Testing Instructions

* On prod, open two tabs. Subscribe a contact to a workflow and refresh both tabs to get them into the same state (though the change should also come through via DMS).
* On tab one, open the management modal for the contact and pause the workflow.
* On tab two, open the management modal and see that it still says active.

Repeat these steps in the branch preview -- the management modal on tab two will now show the subscription as paused.

## Bugfix with a story: #13762 "Lead Custom Objects: reapply V2 Back References plus infinite loop fix"

## Related Issues

* Reapplies https://github.com/closeio/close-ui/pull/13671
* Reapplies https://github.com/closeio/close-ui/pull/13737
* applies a fix for the same infinite loop bug on lead V1.

## Background

The story is this:

1. https://github.com/closeio/close-ui/pull/13737 updated a LeadV2-specific query (`customLeadCustomObjectsQuery`) with some new fields (replacing `customObjectId` and `customActivityId` with `customObject { id }` and `customActivity { id }` respectively).
2. But, lead V2 still uses an older query (`legacyLeadCustomObjectsQuery`) in one specific spot (custom field context).
3. I noticed an infinite loop happening on Lead V2, where the query would trigger a refetch of the `LeadCustomObjects`, which would in turn trigger a refetch of `LeadCustomObjectsAndFields`. I'm not 100% on _why_. The fields are not in conflict with one another, but it seems that rather than Apollo merging the results of the two queries it would trigger a refetch.
4. My solution for fixing the loop was to stop using `legacyLeadCustomObjectsQuery` everywhere on Lead V2. Using the same, newer query in everywhere in V2 solved the issue.
5. But, in replacing `legacyLeadCustomObjectsQuery` with `leadCustomObjectsQuery` in a shared hook that is still used by V1 (`useCustomObjectsForLead`), I inadvertently introduced the same issue in the V1 custom objects section, which was now in the same situation of having the two "conflicting" queries running at the same time.

The final commit 11fbaff8c6990d067ebbf7590dad53e8038ac505 addresses this by adding the missing fields to the old version of the query.

## Testing Instructions

1. Visit the branch preview for https://github.com/closeio/close-ui/pull/13671
2. Visit the new lead page
3. observe/reproduce the infinite loop in the network tab
4. Visit the branch preview for this branch
5. Observe the network tab for both lead V1 and V2 (no loop)
6. _Bonus:_ visit the branch preview for https://github.com/closeio/close-ui/pull/13737 and observe/reproduce the infinite loop on V1 but not on V2.

## Feature phase: #14322 "[Paused Workflows] `PausedSubscriptionsBanner` refactor, part 1"

## Related Issues

Part of https://github.com/closeio/close-ui/issues/14215

## Description

I am refactoring these banners in a few steps. This PR does the following:

1. Moves the banner content "in-house" by adding an `activityType` prop and a child component for rendering the copy.
   * added a `direction` prop which only kicks in if the activity type is `Call`
2. switches the prop API to accept the `PausedSubscription` type. Eventually this will be `PausedSubscription[]`, and the component will own the business of looping/reducing paused subscriptions (currently happening from outside)

Additionally:
1. fixed the `_paused_subscriptions` field on our SMS type, which was `any[]`
2. removed the `CallPausedSubscription` type, which was a duplicate save for some slightly different `null`/`undefined` differences, and replaced with `PausedSubscription`
3. added a storybook story
4. added test coverage
5. dropped a dead wrapper component that seems to be handled by `Stack` now 👌

## Screenshots

This should result in no user-facing changes:

<details>
  <summary>Desktop</summary>

### Fullscreen MMS
[[ image ]]

### MMS
[[ image ]]

### Call (old lead page)
[[ image ]]

</details>

## Testing Instructions

I've been using NPI contact search to find leads where there is a "Goal Met" workflow, which is a good place to see these banners in practice.

## Additional Notes

Next up:
1. refactoring `EmailPausedSubscription` to also use this same component
2. redesigning the banners' content to be behind a collapsible toggle
3. updating the prop to `PausedSubscription` and moving the mapping in-house
4. updating to support multiple contacts per workflow ID

## Early phase with rough bits: #16257 "Custom Activity Triggers: introduce simpler tokens component"

## Related Issues

- Part of https://github.com/closeio/close-ui/issues/15554

## Description

non-lead workflow triggers are much simpler: just a flat list of filters, no nesting or grouping. After banging my head on getting the existing `TokensDisplay` UI to worth with this very different design, I finally landed on the fact that really we should just render a list of tokens ourselves and not even bother with that component 💀

So, this renames that component `MultiRowTokensDisplay` and I introduce a simpler `SingleRowTokensDisplay` that, after some abstracting of how tokens are rendered, just renders a flat list of tokens.

This is still a little rough, but I'm getting it out there so we can continue to collaborate on this UI (Randy being the one to figure out the "empty filters" business)

### Rough bits
* no match operator selector, I'm just rendering the enum straight into the copy 😃
* When you choose a specific custom object type, it's not reflected in the UI anywhere
* Saving still doesn't work
* It still says "Lead matches filter". That's wrong!
* You can "Add filter" and add filters for a _different_ custom activity type, which shouldn't be allowed...

### Changes to Owned Code

Team: @closeio/data-insights-frontend
- Just some renaming of `TokensDisplay` and some refactors to how tokens are rendered within so that it can be shared

A&I for everything else.

## Screenshots

<details>
  <summary>Desktop</summary>

[[ image ]]

</details>

## Testing Instructions

With the `EXTENDED_WORKFLOW_TRIGGERS` flag on, add a custom activity trigger and play with adding/editing filters

## Next up

I think there's another large-ish restructure we need to do here.

Currently, I'm switching `Multi`/`Single` tokens display deep inside `styles.triggerCard`. But I think we need to do this a bit higher. It's the filter's `objectType` that tells us which activity we're filtering on:

[[ image ]]

Which is what we need in order to show the correct activity name.

So we might need to do like `LeadTriggerCard` and `ObjectTriggerCard` and switch off that. `LeadTriggerCard` renders `MultiRowTokensDisplay`, and `ObjectTriggerCard` (which would be used for Opps and Contacts as well I assume) would use this newer, simpler one.

## Refactor, first of a series: #14020 "Design System: Begin moving non-atoms out of atoms/ directory"

Welcome to a very boring PR review!

## Related Issues

Part of https://github.com/closeio/close-ui/issues/11814
Follows https://github.com/closeio/close-ui/pull/12840

## Background

As part of our effort to align our design system with Figma, we're trimming down the `atoms/` directory to the components that both design and eng agree are atoms. This is the first of a few PRs to try to trim down that directory.

## Description

The first (and easiest) step here it to move the utility components (components that don't render actual UI, or that facilitate a pattern rather than a component) out of that directory.

Most of these were already moved to `Utilities` in Storybook, this actually moves them out of the atoms folder.

* Most of these are the items we already determined were utilities in https://github.com/closeio/close-ui/pull/12840
* I've moved `BlockNavigationModal` alongside the other generic/global modals in `modals/`.
* I've moved and renamed AutocompleteInput since it's email-specific, as discussed in https://github.com/closeio/close-ui/pull/13984.

## Testing Instructions

Just moving things around, no visual changes!

## Additional Notes

Some other ways to move things that I'll be exploring in future PRs:
* more deprecation (`atoms/deprecated`)
* Moving more components to their domain-specific dirs
* colocating old/one-off "atom"s with the code that uses it

## Refactor with reviewer guidance: #13738 "Lead V2: split out Inline Custom Field Select Input UI"

## Related Issues

- Part of https://github.com/closeio/close-ui/issues/13636
- Prerequisite for https://github.com/closeio/close-ui/issues/10765

## Description

See discussion in https://github.com/closeio/close-ui/issues/13636 -- basically we need to split apart the visual side of the inline-editing inputs from the actual inline-editing functionality.

This does so for custom field select inputs: (Choices, User, Contact and Custom Object)

**Apologies in advance that the commit diffs are a little tricky to follow.** It might be easier to look at the final diff rather than commit-by-commit

These are the steps I took:

1. Fix some typing (ad57b3d and 6dc3827).
2. 46955cd looks like a lot of new code but what I've really done is:
   1. Added a new `CustomFieldValueInput` directory ("vanilla" companion to `InlineEditableCustomFieldValueInput`)
   1. For each choice-based field type, copied all the code from its respective `InlineEditable` version _except_ for the pieces that are dependent on inline-editing context (`useInlineEditableFieldSelectProps`).
   2. This results in components that are UI for custom field selects, but just accept a value / fire a callback like vanilla selects.
   3. Part of this includes removing the single/multiple "router" components in favour of exporting specific components for multi/single versions.
   5. but they use the fancy triggers.
6. Then there are separate commits where I remove all of that duplicate code from the inline-edit versions and replace that with the just-created "vanilla" versions. The inline-edit versions are now basically HOCs providing the selects with props (including the highlightText prop).
   * For each, I also update `InlineEditableCustomFieldValue` to stop using the single/multi router components in favour of checking `acceptsMultipleValues` directly.
7. Then, I move and renamed the trigger components to be colocated with the "vanilla" UI components, since these are now not unique to inline-editing.

There are no user-facing changes here, but it sets me up in the next PR to build out custom field form fields that share UI with the inline-editing view but that I can compose without any of the inline-editing-specific form wrapping / event handling / async submission.

### Organization

The name and location of the "vanilla"-vs-"inline-edit" versions of this UI might change, I'm not 100% happy. I think `CustomFieldValueInput` is misleading since we have custom field value inputs elsewhere (e.g. custom activities). Should we maybe keep it all under `InlineEditableCustomFieldValueInput` but use the `Raw` prefix?

## Testing Instructions

Play with choice-based custom fields in the sidebar -- there should be no difference in behavior.

## Bulk mechanical batch: #20456 "Storybook: enable `Meta` linting, update everywhere, fix stragglers"

## Related Issues

- Wraps up the work started in https://github.com/closeio/close-ui/pull/20020

**For reviewers:** It's probably safe to skip reviewing commits 2 & 3, these are bulk search-and-replace changes.

There is one TS error I skipped: <commit link> There is a mismatch between how the story is orchestrated and the props the components accept... needs a closer look.

Once this is shipped I will re-announce these typing changes.

## Description

Here I actually enable the lint rule and clean up the remaining issues. The "remaining issues" part ended up being larger than I expected, several stories slipped through the cracks it seems 🙃

### Changes to Owned Code

Every team is tagged. If you're tagged I just adjusted some of your stories, switching all to `const meta = {} satisfies Meta<typeof Component>` and `type Story = StoryObj<typeof meta>`.

## Screenshots

No user-facing changes!

## Flag release: #18023 "Workflows: release tabbed modal (recipient select only) and redesign trigger config"

## Related Issues
- Stacks on https://github.com/closeio/close-ui/pull/18077
- Closes https://github.com/closeio/close-ui/issues/17590
- Closes https://github.com/closeio/close-ui/issues/17634
- Closes https://github.com/closeio/close-ui/issues/17610

## Description

Here we unflag a bunch of previously shipped UI:
* The tabbed modal
* The recipient select within the modal rather than in the trigger config
* The communication details card

Alongside this, we redesign the trigger card, since it no longer includes recipient details.

### Changes to Owned Code
Team: All A&I

## Screenshots

<details>
  <summary>Desktop</summary>

### "Match all" Contact trigger
[[ image ]]

### Contact trigger with filters
[[ image ]]

### "Match all" Lead trigger
[[ image ]]

### Lead trigger with filters
[[ image ]]

</details>

## Testing Instructions

1. Disable the `CONTACTLESS_WORKFLOWS` flag
2. Add some triggers, add/remove filters
3. Add a communication step and notice the communication details card is there
4. Open the modal and notice the tabs are there
5. re-enable `CONTACTLESS_WORKFLOWS` and notice that you get the run once/multiple radio control

## Additional Notes

### Run Multiple sneak-peek

With the rollout of the communication details card, we now say "run once per contact"... of course this is self-evident at the moment until operational workflows are released but I think it's OK to still include this in the UI?

[[ image ]]

---

> [!NOTE]
> **User-Facing Change**
>
> * Aside from minor UI adjustments, the main user-facing difference is that the recipient select is now in the "Recipient and Schedule" modal rather than in the trigger step.
