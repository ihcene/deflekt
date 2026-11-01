---
title: Deflekt for Sentry
name: Sentry
kicker: Errors
order: 3
headline: Sentry tells you what broke. <em>Deflekt tells you who it hurt, and fixes it.</em>
description: Deflekt reads your Sentry issues, stack traces and event context, links each error to the customers and tickets it causes, and turns a rising error into one investigation with a tested fix.
facts:
  Category: Error tracking
  Access: Read only API token
  Reads: Issues, events, stack traces, context
  Also: Browser extension panel on Sentry issues
---

Most teams have a Sentry project full of errors nobody has time to open. The ones that matter are hidden among the noise, and the only signal that one of them hurts real people is a ticket that arrives days later.

## What Deflekt reads

- **Issues and their trend.** New, regressed and rising issues, with event counts over time.
- **Stack traces and breadcrumbs.** The exact line, the request that triggered it and what happened just before.
- **Event context.** User, account, release and environment, so an error can be tied to a customer.
- **Releases.** Which deploy introduced the issue, matched with the pull requests that shipped in it.

## What it does with it

1. **Links errors to people.** A `TimeoutError in BankSyncJob` becomes "three customers have written about missing transactions, and here are the accounts".
2. **Investigates the cause.** It reads the code at the failing line, the recent changes around it and the data involved, read only.
3. **Groups duplicates.** Twelve issues with the same root cause become one case, not twelve tickets.
4. **Proposes a fix.** A pull request with a regression test, recorded before and after when the change is visible.

## Inside Sentry

With the Deflekt browser extension, a panel appears on every Sentry issue with the investigation, the customers affected and the proposed fix. You never have to leave the page you are on.

## Setup

1. Create an internal integration in Sentry with read access to issues, events and releases.
2. Paste the token in Deflekt and choose the projects to watch.
3. Optionally, point a Sentry alert webhook at Deflekt so new issues are picked up the moment they appear.

Deflekt only reads from Sentry. It does not resolve, ignore or assign issues unless you ask it to. See it next to [GitHub](/integrations/github/) for fixes, or read how it catches [regressions after a deploy](/use-cases/deploy-regressions/).
