---
title: Silent data bugs
kicker: Data Watch
order: 2
headline: The export stopped working on Tuesday. <em>Nobody wrote in.</em>
description: Some bugs never produce a ticket or an error. Deflekt watches your product's own data every night and notices when a feature stops writing, long before a customer does.
facts:
  Signals: Nightly probes of your own database
  Reads: Tables, jobs, code, recent deploys
  Prepares: Alert, cause, affected accounts, fix
  Approval: Always by your team
---

The worst bugs are the quiet ones. A job keeps running, the logs stay green, the error tracker has nothing to say. But a table that used to grow every night has stopped growing, and the first person to notice is a customer's accountant three weeks later, looking for a file that was never written.

## What usually happens

Nobody is watching. Error trackers catch exceptions, not absences. A job that succeeds while writing zero rows looks exactly like a job that worked. When the complaint finally arrives, the team has to reconstruct weeks of history, find every account that missed its data, and explain why nobody saw it sooner.

## What Deflekt does instead

1. **Probes your database every night, read only.** It checks that features which usually write still write, that columns which are usually filled are still filled, and that no status appears that nobody has seen before.
2. **Learns what normal looks like from history.** Rules come from months of real data and are backtested before they raise anything, so a quiet Sunday does not wake anyone up.
3. **Flags the change the morning it happens.** The nightly export for Hallberg Logistik's accounts wrote zero rows two nights in a row, after writing between 900 and 1,400 every night since March.
4. **Finds the cause in the code.** A dependency upgrade in PR #4688 changed how the CSV library handles an empty header option, and the export now filters out every row before writing.
5. **Prepares what your team needs.** The list of affected accounts, a pull request with a test that fails on the old behaviour, and a console command to rerun the two missed exports once the fix is merged.

```
# data watch, read only
nightly_exports.rows_written, last 2 nights
→ 0 · 0 (usual range 900 to 1,400)
# code and history
PR #4688 upgraded the csv gem, export_job.rb:41 now drops every row
# verdict
bug · urgent · data missing for 214 accounts, no complaint yet
```

## Why it matters

> A missing row never raises an exception.

The longer a silent bug runs, the more data has to be rebuilt and the harder the conversation with customers becomes. Two days of missing exports is a rerun and a short note. Three weeks is an incident, a backlog of manual corrections and a customer who wonders what else is quietly broken.

## What stays with your team

Deflekt only reads your database. It does not rerun jobs, backfill tables or change data on its own. The rerun command waits for a developer to execute it, the fix goes through your tests and your review like any other pull request, and every rule it has learned can be inspected and dismissed. When you dismiss an alert, it remembers why. Read the [silent export case](/case-files/silent-export/), see how Deflekt reads [PostgreSQL](/integrations/postgresql/), or compare it with [deploy regressions](/use-cases/deploy-regressions/).
