---
title: Deflekt for Freshdesk
name: Freshdesk
kicker: Help desk
order: 1
headline: Freshdesk holds the question. <em>Deflekt comes back with the answer.</em>
description: Deflekt picks up every new Freshdesk ticket and reply, investigates it in your code and data, and drafts the reply or private note your team approves before anything is sent.
facts:
  Category: Help desk
  Access: API key and webhooks
  Reads: Tickets, conversations, attachments, contacts, companies
  Also: Browser extension panel on tickets
---

In most Freshdesk queues, the slow part is not writing the reply. It is finding out what actually happened. An agent reads the ticket, asks a developer, the developer opens the database, and the customer waits two days for an answer that took ten minutes to find.

## What Deflekt reads

- **New tickets and replies.** Freshdesk webhooks send each new ticket and each customer reply to Deflekt the moment it arrives.
- **The full conversation.** Every public reply and private note on the ticket, so it knows what the team has already tried.
- **Attachments and inline images.** Screenshots pasted in the message body, PDF invoices, CSV exports and logs are read like the rest of the text.
- **Contact and company.** Who wrote, which account they belong to, and every earlier ticket from the same people.

## What it does with it

1. **Investigates the case.** It searches the code, recent deploys, Sentry and the customer's account data, read only.
2. **Sets a priority from evidence.** Money moved wrongly or a blocked customer without a workaround is urgent, whatever the reporter picked. Both priorities are shown side by side.
3. **Drafts the response.** A reply in the customer's language and your team's tone, or a private note when the customer needs nothing yet.
4. **Prepares the fix when there is one.** A console command for a single account, or a pull request tested side by side.
5. **Waits for approval.** Only after someone on the team approves does Deflekt post the reply or note, and resolve the ticket if the case is closed.

## One ticket, start to finish

Pieter from Van Damme Bouw writes in Dutch on ticket #5172: he was charged twice this month, with a screenshot of his bank statement attached. Deflekt reads the screenshot, finds 38 subscriptions charged twice for €4,218.40, and traces it to a webhook that lost its idempotency key in PR #2214. Sarah in support gets a Dutch reply ready to send, a private note explaining the cause, and a link to the 9 line fix in PR #2231 waiting for Lina's review.

## Inside Freshdesk

With the Deflekt browser extension, a panel opens next to each ticket with the investigation, the evidence, the proposed reply and the priority. Agents approve, edit or discard without leaving the ticket.

## Setup

1. Create a Freshdesk agent for Deflekt and copy its API key from the profile settings.
2. Paste the key and your Freshdesk domain in Deflekt and choose the groups to watch.
3. Add two automation rules, one on ticket creation and one on ticket updates, that call the Deflekt webhook URL.
4. Install the browser extension for the agents who handle tickets.

Deflekt never sends anything to a customer on its own. Every reply, note and resolution waits for a person to approve it. See how it answers customers in [their own language](/use-cases/multilingual-support/), or follow the [double charge case](/case-files/double-charge/) from ticket to merged fix.
