---
title: Do we send a reminder before the due date?
kicker: Case 5034
date: 2026-10-05
order: 4
headline: A question from sales. <em>A feature four customers wanted.</em>
description: Sarah asked whether the app sends a reminder before an invoice is due. Deflekt answered from the code and the data, then noticed four customers had asked for a seven day option, and prepared a spec and a small pull request.
facts:
  Product: Invoicing SaaS, Belgium
  Signal: A question from sales
  Found: 4 customers asking for the same thing
  Time to answer: 3 minutes
---

Monday, 14:20. Sarah is on a call with a prospect who wants to know whether the app reminds their clients before an invoice is due. She asks Deflekt instead of waiting for a developer.

## 14:21, the answer

Deflekt answered from the code, with the source cited:

```
> app/jobs/payment_reminder_job.rb
  sends a reminder 3 days before the due date
  only when "payment reminders" is enabled in company settings
  email only, in the client's language
> companies with payment reminders enabled: 612 of 1,380
> reminders sent last 30 days: 18,904
```

Yes, the app sends a reminder three days before the due date, by email, when the setting is turned on. 612 companies use it, and it sent close to nineteen thousand reminders last month. Sarah had her answer before the prospect finished the next question.

## 14:23, the pattern

Deflekt keeps a file per customer and remembers every request. While answering, it noticed that the same question had come up before, in a different form. Four customers had asked, in separate tickets over the past five months, for the reminder to go out earlier:

- Atelier Moreau, in French, in May.
- Brouwers Logistiek, in Dutch, in July.
- Kessler Haustechnik, in German, in August.
- Hollis Studio, in English, last week.

All four wanted the same thing: a reminder seven days before the due date. Each ticket had been closed with a polite no.

## 14:30, the spec

Deflekt drafted a short spec. The setting gets a choice between three and seven days, three stays the default, and nothing changes for the 612 companies already using it. It checked the job and the scheduler: the delay is a single constant, so the change is small.

## 14:41, the pull request

The pull request adds the setting, reads it in the reminder job and covers both values with tests. It was run in two environments with the same data, before and after, and the recording of the settings page and the scheduled reminders was attached. Deflekt also drafted a short reply for each of the four customers, in their language, to send once the change ships.

## The next day

Lina reviewed the change, asked for one rename, and Deflekt handled it in a second round. It shipped on Wednesday. Support approved the four replies.

> The prospect signed. The four customers heard back the same week.

## What was remembered

Deflekt linked the four tickets to the feature, so the next customer who asks gets a yes. Feature work is not where Deflekt spends most of its time, but when a request keeps coming back, it notices. See the [product questions use case](/use-cases/product-questions/) and the [feature requests use case](/use-cases/feature-requests/).
