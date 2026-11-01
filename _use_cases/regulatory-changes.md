---
title: Regulatory changes
kicker: Regulation
order: 5
headline: The rule changes on January 1. <em>Deflekt flagged it in September.</em>
description: Regulators and partners announce changes long before they apply, in documents nobody on the team has time to read. Deflekt reads them, judges each against your product and points to the code it affects.
facts:
  Signals: Regulator feeds, partner changelogs
  Reads: Announcements in any language, your code
  Prepares: Impact note, affected code, draft spec
  Approval: Always by your team
---

Every product that sends invoices, moves money or handles personal data depends on rules it does not control. Tax authorities publish new requirements, payment partners deprecate an endpoint, an email provider changes its limits. The announcement usually arrives months ahead, in a long document, often in a language half the team does not read.

## What usually happens

Someone hears about it from a customer, an accountant or a competitor's newsletter, a few weeks before the deadline. The team scrambles to understand what the rule actually says, which parts of the product it touches and how much work it is. The change ships late in December, under pressure, with less testing than anyone would like.

## What Deflekt does instead

1. **Reads the feeds you point it to.** Regulator publications and partner changelogs, in Dutch, French, German or English, checked every day.
2. **Judges each item against your product.** Most announcements do not concern you. A new electronic invoicing rule requiring a single continuous numbering sequence per legal entity from January 1 does, because your product numbers invoices per team.
3. **Points to the code it affects.** The numbering service, the invoice model, the PDF template that prints the number, and the 312 accounts with more than one team on the same company number.
4. **Writes an impact note and a draft spec.** What changes, from when, which accounts are concerned, what to decide, and the questions your team has to answer before anyone writes code.
5. **Learns from what you dismiss.** If an item does not apply, tell it why once. Similar items will be judged accordingly, and a feed that has gone silent for too long gets flagged too.

```
# regulator feed, fr
"numérotation continue et unique par entité juridique, à partir du 1er janvier"
# code and data, read only
invoice_number_service.rb:14 sequences per team, not per legal entity
→ 312 accounts with several teams on one company number
# verdict
regulatory · applies · 4 months ahead, spec drafted
```

## Why it matters

> Four months of notice is a project. Two weeks is an incident.

Regulatory work is rarely hard. It becomes hard when it is discovered late. Knowing in September what has to change on January 1, and where, lets the team plan it like any other piece of work and talk to affected customers early.

## What stays with your team

Deflekt does not interpret the law for you and does not change your product on its own. It tells you what was published, why it thinks it applies and which code is involved. Your team decides what to build and when. Read the [numbering change case](/case-files/numbering-change/) or see how Deflekt turns findings into specs for [feature requests](/use-cases/feature-requests/).
