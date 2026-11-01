---
title: A rule published three months early
kicker: Case 4886
date: 2026-09-29
order: 3
headline: A new rule on invoice numbers. <em>Three months to get ready.</em>
description: Regulatory watch flagged a published rule on electronic invoice numbering, effective January 1. Deflekt mapped it to the code that numbers invoices and drafted a spec the same morning.
facts:
  Product: Invoicing SaaS, Belgium
  Signal: Regulatory watch, a notice in French
  Found: 3 code paths, 214 companies affected
  Time to answer: 22 minutes
---

Tuesday, 09:10. The tax administration publishes a notice in French on its news feed. Nobody on the team reads that feed every day. Deflekt does.

## 09:11, the notice

The notice sets new rules for the numbering of electronic invoices, effective January 1. Invoice numbers must follow one continuous sequence per issuer, credit notes included, and no number may be skipped or reused. Separate series are still allowed, as long as each one is continuous and identified by a fixed prefix.

Regulatory watch judged it against the product and marked it relevant: this is an invoicing product, and numbering is at its core. A month earlier the team had dismissed a notice about paper archiving, and Deflekt had learned from it. This one was different.

## 09:16, the code

Deflekt searched the codebase for everything that assigns an invoice number and found three paths:

1. The main numbering service, which already uses one continuous sequence per company.
2. Credit notes, which use a separate sequence with no prefix. Allowed by the rule only if a fixed prefix is added.
3. The public API, which lets customers send their own invoice number. Nothing checks that those numbers follow a sequence.

It also found that deleting a draft releases its number, which creates gaps when the draft was numbered early.

## 09:24, the data

A read only query showed the size of it. 214 of 1,380 companies send their own numbers through the API. 41 companies have at least one gap in their sequence this year, all caused by deleted drafts. Most credit notes in the product would need the new prefix.

## 09:32, the spec

Deflekt drafted a spec for the team, with the source of each point cited:

- A fixed prefix for credit note series, set once per company, with existing numbers left untouched.
- Validation on API numbers, rejecting a number that breaks the sequence, with a clear error message.
- Numbers assigned at the moment of sending, not when a draft is created, so deleting a draft no longer leaves a gap.
- An email to the 214 API customers, in their own language, two months before the deadline.

It flagged one open question for a human: whether existing gaps from earlier this year need to be documented for the customers concerned.

> The rule was public for one day before the spec existed.

## What was remembered

Marc read the summary in the next morning's brief and put the spec on the October roadmap. Deflekt scheduled a follow up for December 1 to check that the change had shipped and the API customers had been told. See the [regulatory changes use case](/use-cases/regulatory-changes/) and how Deflekt turns findings into [feature requests](/use-cases/feature-requests/).
