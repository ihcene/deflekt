---
title: Deploy regressions
kicker: Regressions
order: 3
headline: Six tickets and forty errors since Thursday. <em>One pull request.</em>
description: When a release breaks something for some accounts, the signals arrive scattered across support and the error tracker. Deflekt groups them, ties them to the pull request that caused them and prepares the fix.
facts:
  Signals: Help desk tickets, error tracker, deploys
  Reads: Pull requests, stack traces, code, accounts
  Prepares: Grouped incident, replies, fix with proof
  Approval: Always by your team
---

A regression rarely breaks everything. It breaks something for the accounts with a specific setting, a specific plan or a specific language. Support sees a few unrelated complaints, the error tracker sees a new exception with a modest count, and nobody connects them to the release that went out the afternoon before.

## What usually happens

Each ticket gets handled on its own. A support agent asks for a screenshot, a developer looks at one stack trace, someone suggests clearing the cache. Two days later, an engineer finally notices that all of it started at the same hour, and the hunt through the deploy history begins.

## What Deflekt does instead

1. **Notices the cluster.** Six tickets in three languages and a new error in the tracker, all starting within an hour of Thursday's 16:20 release.
2. **Reads the stack traces and the accounts behind them.** Every failing account has delivery slots enabled and a time zone other than Europe/Brussels.
3. **Ties the errors to the pull request.** PR #5021 moved slot calculation to a new service and dropped the account's time zone, so slots crossing midnight now raise on save.
4. **Sets the priority from evidence.** Customers cannot confirm bookings and have no workaround, so it is urgent, whatever priority the first ticket was given.
5. **Prepares the fix and the replies.** A pull request restoring the time zone, a test with an account in Lisbon, a recording of the booking flow before and after on the same data, and a reply to each customer in their own language.

```
# error tracker and tickets
SlotOverlapError · 43 events · 17 accounts · first seen Thu 16:34
6 tickets (nl, fr, en) mention "cannot confirm"
# code and history
PR #5021 deployed Thu 16:20, slot_service.rb:58 ignores account time zone
# verdict
regression · urgent · bookings blocked, no workaround
```

## Why it matters

> The fastest way to fix a regression is to know which pull request caused it.

Once the cause is known, most regressions are a few lines. The expensive part is the time between the release and the moment someone links the symptoms together, and every ticket answered on its own in the meantime.

## What stays with your team

Deflekt does not revert deploys or push to your main branch. The fix is a pull request that runs through your tests and your review, with the recording playing inside it so the reviewer can see the behaviour change. Replies are drafts until support approves them. If a reviewer leaves a comment or CI fails, Deflekt picks it up in the next round. See how it reads [Sentry](/integrations/sentry/) and [GitHub](/integrations/github/), or how it compares with [Sentry Seer](/compare/sentry-seer/).
