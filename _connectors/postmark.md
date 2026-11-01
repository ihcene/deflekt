---
title: Deflekt for Postmark
name: Postmark
kicker: Email
order: 14
headline: Did the customer receive the invoice email? <em>Deflekt checks Postmark and answers.</em>
description: Deflekt reads Postmark message events, bounces, spam complaints and delivery status, so questions about missing emails get an answer backed by evidence instead of a guess.
facts:
  Category: Email
  Access: Server API token, read calls only
  Reads: Messages, events, bounces, spam complaints
  Also: Draft replies with the delivery evidence
---

"I never received the invoice" is one of the most common tickets a SaaS product gets, and one of the slowest to answer. Support asks a developer, the developer searches the email logs, and the customer waits a day for an answer that takes thirty seconds once you know where to look. Meanwhile the invoice stays unpaid and the reminder goes out to an address that does not work. The Postmark connector is live today.

## What Deflekt reads

- **Outbound messages.** Every email sent to a recipient, with its subject, tag, message stream and timestamp.
- **Message events.** Delivered, opened, link clicked, bounced, so Deflekt knows what happened after the email left.
- **Bounces.** The bounce type and the reason the receiving server gave, such as a full mailbox or an unknown address.
- **Spam complaints.** Recipients who marked a message as spam, and are no longer receiving anything from you.

## What it does with it

1. **Finds the message.** It searches Postmark for emails sent to the customer's address around the date in question.
2. **Reads what happened.** Delivered and opened, delivered but never opened, bounced, or never sent at all.
3. **Checks your side.** When there is no message in Postmark, it looks at the code and the data to see why your product never sent it.
4. **Drafts the reply.** In the customer's language, with the delivery evidence and the next step.

## Did the invoice email arrive?

Take case #4417. The accountant at Bureau Lambert wrote in French that the October invoices never arrived. Deflekt found the message in Postmark: delivered on 2 October at 09:12, then a hard bounce on the next three emails because the mailbox had been deleted. The contact had changed jobs. Sarah received a draft reply in French explaining the bounce and asking for the new address, plus a note that the bounce had deactivated the address in Postmark and would need to be reactivated once corrected.

When the message is missing from Postmark entirely, the case becomes a bug investigation instead, and Deflekt follows it into the code that sends the email: a background job that failed, a template that raised an error, or a contact without an address.

## Setup

1. In Postmark, open the server that sends your transactional email and copy its Server API token.
2. Paste it in Deflekt. It is encrypted at rest and scoped to one project. Deflekt only calls the read endpoints for messages, bounces and complaints.
3. Choose the message streams Deflekt should look at, for example your transactional stream but not your broadcasts.

Deflekt never sends, resends or reactivates anything in Postmark without a human approving it. Read how it answers [product questions](/use-cases/product-questions/), how it replies in [several languages](/use-cases/multilingual-support/), or see the [Freshdesk](/integrations/freshdesk/) connector.
