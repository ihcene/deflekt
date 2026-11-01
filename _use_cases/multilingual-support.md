---
title: Multilingual support
kicker: Languages
order: 4
headline: The ticket is in German. <em>The developer on duty reads Dutch.</em>
description: European customers write in their own language, and your developers do not speak all of them. Deflekt investigates in any language, replies in the customer's, and writes internal notes in your team's.
facts:
  Languages: Dutch, French, English, German and more
  Reads: Tickets, attachments, history, code
  Prepares: Reply in the customer's language, note in yours
  Approval: Always by your team
---

A Belgian invoicing product can receive tickets in Dutch, French, English and German on the same morning. The support team usually covers two or three of those languages. The developers often cover one or two, and not always the same ones. Every ticket in the wrong language adds a translation step before anyone can start working on it.

## What usually happens

Someone pastes the ticket into a translator, loses the nuance, and forwards it to engineering. The developer answers in English. Support translates the answer back, adjusts the tone, and hopes nothing technical got lost on the way. A screenshot in German or a PDF invoice in French gets skimmed rather than read. Each round trip adds hours, and the customer can tell.

## What Deflekt does instead

1. **Reads the ticket in the language it was written in.** Including attachments: a screenshot of a German error message, a French PDF, a Dutch CSV export.
2. **Investigates like any other case.** Klaus, from Brandt Haustechnik, writes that his credit notes show the wrong VAT rate. Deflekt checks his account, his recent documents and the code that computes the rate.
3. **Writes the internal note in your team's language.** Lina reads in English that the account has a reverse charge setting enabled by mistake, with the query that shows it and the console command to correct it.
4. **Drafts the reply in the customer's language and your team's voice.** German for Klaus, with the same greeting, the same level of formality and the same sign off your support team uses, learned from past replies.
5. **Keeps the thread consistent.** If Klaus answers in German, the follow up stays in German. If a contact usually writes in French, Deflekt remembers it in their file.

```
# ticket #4931, de
"Die Gutschriften zeigen 0 % MwSt statt 19 %"
# account, read only
Brandt Haustechnik · reverse_charge = true since Sep 12 · 7 credit notes
# verdict
configuration · normal · note in en, reply in de, console command ready
```

## Why it matters

> Customers notice when the answer comes back in their own language.

For a European product, language is part of the service. A precise answer in the customer's language, written the way your team writes, removes the doubt that a translated reply leaves behind. And your developers can work on every ticket, not just the ones they can read.

## What stays with your team

Every reply is a draft. Support reads it, edits it if needed and sends it, or approves it so Deflekt posts it to the help desk. The console command waits for a developer to run it. Deflekt never changes the account on its own. See how it works with [Freshdesk](/integrations/freshdesk/) and [Zendesk](/integrations/zendesk/), or read how a Dutch ticket became the [double charge case](/case-files/double-charge/).
