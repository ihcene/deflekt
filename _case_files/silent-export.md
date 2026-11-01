---
title: The export that wrote nothing
kicker: Case 4917
date: 2026-10-12
order: 2
headline: The export ran every night. <em>It wrote nothing.</em>
description: A nightly accounting export wrote zero rows for two nights after a dependency upgrade. No ticket, no error. Data Watch noticed, and Deflekt had the cause, the customers and the fix ready before the first coffee.
facts:
  Product: Invoicing SaaS, Netherlands
  Signal: Data Watch, no ticket
  Found: 63 companies, 1,912 invoices missing
  Time to answer: 14 minutes
---

Monday, 06:00. Nobody has complained. The nightly accounting export, which sends each customer's invoices to their bookkeeping tool, ran on Saturday and on Sunday without a single error. Every file arrived on time.

## 06:02, the signal

Data Watch runs its probes on the product's own database every night. One of them counts the rows each export writes. History showed that a quiet Saturday can produce an empty export, so one empty night is not a signal. Two in a row, on accounts that issued invoices both days, is. The rule had been backtested on a year of data before it was switched on. It fired.

## 06:05, the cause

Deflekt compared the last good export with the first empty one and looked at what changed between them. One deploy, Saturday at 10:15, included a dependency upgrade of the CSV library in pull request #4471.

```
> exports where rows_written = 0 and invoices_in_period > 0
  2026-10-10  63 companies
  2026-10-11  63 companies
> last export with rows: 2026-10-09 23:30
> deploys since: 2026-10-10 10:15  PR #4471  bump csv library
> changelog: rows are now written lazily, file must be closed after iteration
```

The new version streams rows lazily. The export job opened the file, wrote the header, and closed it before the rows were ever read. Each file contained a header line and nothing else. No exception, nothing in the error tracker.

## 06:09, the customers

A read only query listed everyone affected: 63 companies on the accounting export, 1,912 invoices missing from their bookkeeping for the two days. Three of those companies close their books on the fifteenth, so the gap would have surfaced in an accountant's office the following week, as a ticket nobody could explain.

## 06:14, the answers

Deflekt prepared three things for the team:

1. A pull request that consumes the rows before closing the file, with a test that fails if an export with invoices writes zero rows.
2. A backfill command that reruns the export for October 10 and 11 for the 63 companies, waiting for a human to run it after the merge.
3. An internal note for support with the list of companies, in case one of them writes in before the backfill lands.

The fix was run in two environments with the same data. Before, an empty file. After, 1,912 rows. The recording was attached to the pull request.

## 08:40, the approval

The developer on duty reviewed the change, merged it and ran the backfill. The bookkeeping tools received the missing invoices before any customer opened one.

> Nobody wrote in, because nobody had noticed yet.

## What was remembered

Deflekt kept a lesson for the next upgrade of that library: its changelog matters for every job that writes files. The next pull request that bumps it will be checked against every export. See the [silent data bugs use case](/use-cases/silent-data-bugs/) and how Deflekt reads [PostgreSQL](/integrations/postgresql/).
