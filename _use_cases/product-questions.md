---
title: Product questions
kicker: Questions
order: 6
headline: Do we already send a reminder before the due date? <em>Ask Deflekt, not an engineer.</em>
description: Sales, support and operations ask how the product behaves every day. Deflekt answers from the code and the data, cites its sources, and leaves your engineers to their work.
facts:
  Asked by: Sales, support, operations, anyone
  Reads: Code, configuration, production data
  Answers: In plain words, with sources cited
  Approval: Nothing to approve, read only
---

Most interruptions an engineer gets in a day are not bugs. They are questions. A prospect asks whether invoices can be sent in two languages. A customer success manager wants to know how many accounts use a setting before calling one of them. Support needs to know whether a behaviour is a bug or how it was built.

## What usually happens

The question goes to a Slack channel and waits for whoever knows that part of the code. That person stops what they were doing, opens the repository, checks a feature flag, maybe runs a query, and answers from memory with a caveat. The same question comes back a month later from someone else, and the answer is no longer quite true.

## What Deflekt does instead

1. **Takes the question from anyone.** Sophie, in sales, is on a call with Lefebvre Distribution and asks whether the product already sends a reminder before an invoice is due.
2. **Reads the code that decides it.** The reminder scheduler, its settings and the email templates it uses, on the current main branch.
3. **Checks the data, read only.** How many accounts have the setting enabled and how many reminders actually went out last month.
4. **Answers in plain words, with sources.** Yes, three days before the due date, but only for accounts that turned it on. It is off by default. The answer links to the file, the setting and the query.
5. **Remembers the question.** When someone asks again, the answer is checked against the code as it is today, not as it was when it was first given.

```
# question from Sophie, sales
"do we already send a reminder before the due date?"
# code
reminder_scheduler.rb:22 sends 3 days before due_date when pre_due_reminder is on
# data, read only
pre_due_reminder enabled on 186 of 1,240 accounts · 2,904 sent in October
# answer
yes, opt in, off by default · sources linked
```

## Why it matters

> The answer is in the code. It should not depend on who is available to read it.

An answer from the code is more reliable than one from memory, and it does not cost anyone their focus. Sophie got hers during the call. The engineer who wrote the scheduler never knew she asked.

## What stays with your team

Answers come from read only access to the code and the data, and every one shows where it came from, so anyone can check it. Deflekt does not change settings when it answers a question. Engineers can ask it the same things from their own AI tools through its MCP server. Read the [reminder request case](/case-files/reminder-request/), see how it reads [Metabase](/integrations/metabase/), or what happens when the answer is no in [feature requests](/use-cases/feature-requests/).
