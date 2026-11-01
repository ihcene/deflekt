---
title: Payment bugs and double charges
kicker: Payments
order: 1
headline: One customer was charged twice. <em>Thirty seven others were too.</em>
description: When money moves wrongly, the complaint you receive is rarely the only victim. Deflekt reads the payments, finds everyone affected, and prepares the refunds, the replies and the fix before the rest of your customers notice.
facts:
  Signals: Help desk tickets, payment provider, error tracker
  Reads: Payments, webhooks, code, recent deploys
  Prepares: Refund script, replies, proactive email, fix
  Approval: Always by your team
---

A payment bug never arrives as a payment bug. It arrives as one customer writing, often in their own language, that something looks wrong on their bank statement. By the time a developer reads it, the same thing has usually happened to dozens of accounts that have not written yet.

## What usually happens

Support asks engineering. Engineering opens the payment provider dashboard, then the logs, then the code. Someone writes a query to see how far it goes. Someone else drafts an apology. The refunds wait until all of that is done, and every hour, another customer opens their banking app.

## What Deflekt does instead

1. **Reads the ticket and the customer's history.** It knows who Pieter is, which plan he pays for and how many times he has written before.
2. **Queries the payments, read only.** Every renewal charged more than once since the issue began, grouped by subscription, with the total amount.
3. **Finds the cause in the code.** A webhook handler that lost its idempotency key in yesterday's deploy, and the pull request that removed it.
4. **Separates the one who complained from the ones who did not.** Thirty eight subscriptions affected, one complaint, thirty seven customers still unaware.
5. **Prepares everything your team needs to approve.** A reply in the customer's language, a refund script for every affected payment, a short proactive email to the others, and a pull request with a regression test.

```
# payments, read only
renewals charged more than once since Oct 31
→ 38 subscriptions · €4,218.40 · 1 complaint
# code and history
payment_webhook.rb:27 lost its idempotency key in PR #2214
# verdict
bug · urgent · money taken wrongly, 37 customers unaware
```

## Why it matters

> The customers who never had to write in are the ones you keep.

Fixing the bug is the easy part. Telling thirty seven people before they find out on their own is what protects trust, and it is the step teams skip when they are busy.

## What stays with your team

Deflekt never moves money and never writes to production. The refund script waits for a human to run it, the emails wait for approval, and the fix goes through your tests and your review like any other pull request. Read more about the [double charge case](/case-files/double-charge/) or see how Deflekt connects to [Stripe](/integrations/stripe/) and [Mollie](/integrations/mollie/).
