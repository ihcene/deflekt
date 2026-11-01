---
title: Feature requests
kicker: Requests
order: 7
headline: Eleven customers asked for the same thing. <em>Now you know which one.</em>
description: Feature requests arrive scattered across tickets and calls. Deflekt checks each one against what already exists, scopes it in the code, groups it with similar requests and turns it into a spec your team can decide on.
facts:
  Signals: Tickets, calls, issue tracker, anyone
  Reads: Code, existing settings, past requests
  Prepares: Answer, scoped spec, request count
  Approval: Always by your team
---

Feature requests are the part of the queue that grows quietly. Each one is reasonable, each one is written differently, and most end up in a backlog where nobody can tell how many customers asked for the same thing, or whether the product already does it.

## What usually happens

Support tags the ticket and replies that the idea has been passed on. Product adds a line to a board. Months later, someone tries to prioritise and finds forty cards that might be the same request, with no link to the customers who asked. Some of them describe a feature that already exists behind a setting nobody mentioned.

## What Deflekt does instead

1. **Checks whether it already exists.** Marie, from Atelier Rousseau, asks in French for a reminder before invoices are due. The product already sends one, off by default. Deflekt drafts a reply in French explaining how to turn it on.
2. **Groups it with similar requests.** When a request is new, Deflekt links it to the earlier ones that ask for the same thing, whatever their wording or language, and keeps count of the customers behind them.
3. **Scopes it in the code.** A second reminder seven days before the due date touches the scheduler, one setting and one template. A reminder sent by text message would need a new provider.
4. **Writes a spec your team can decide on.** What the customers asked, what exists today, what would change, open questions and a rough size.
5. **Opens a pull request only when it is small.** For the second reminder, a few lines and a test. Anything larger stays a spec until your team decides, and can then be handed to the coding agent you already use, with the context attached.

```
# request #5388, fr
"un rappel une semaine avant l'échéance, en plus de celui à trois jours"
# existing behaviour
pre_due_reminder: one reminder, 3 days before due_date
# similar requests
11 customers since March · 4 languages · 3 on the Business plan
# verdict
feature · small · spec ready, pull request drafted
```

## Why it matters

> A request counted eleven times is a decision. A request filed eleven times is noise.

Most of the value is not in building faster. It is in answering the customers whose feature already exists, and in giving your team an honest count before they decide what is worth building next.

## What stays with your team

Deflekt does not decide your roadmap and does not merge anything. Replies are drafts, specs are proposals, and the occasional small pull request goes through your tests and your review like any other. Read the [reminder request case](/case-files/reminder-request/), see how Deflekt works alongside [coding agents](/compare/coding-agents/), or how it answers [product questions](/use-cases/product-questions/).
