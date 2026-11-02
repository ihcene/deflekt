---
title: Deflekt for Stripe
name: Stripe
kicker: Payments
order: 11
headline: A billing bug never hits one customer. <em>Deflekt finds all of them.</em>
description: Deflekt reads charges, payment intents, invoices, subscriptions, customers and events with a restricted Stripe key, so a billing complaint becomes the full list of accounts affected and a reviewed repair.
facts:
  Category: Payments
  Access: Restricted API key, read permissions only
  Reads: Charges, payment intents, invoices, subscriptions, customers, events
  Also: Repair scripts prepared for a human
---

When a customer writes that they were charged the wrong amount, the real question is not about them. It is about everyone else the same bug touched, who has not noticed yet. Answering it means comparing your database with Stripe, account by account, and that is the work nobody has time for on a busy afternoon. So the one customer gets a refund, and the others find out from their accountant.

## What Deflekt reads

- **Charges and payment intents.** Amounts, currencies, statuses, failures and the metadata your application attaches to each payment.
- **Invoices and subscriptions.** Line items, proration, billing periods, trial ends and the plan each customer is on.
- **Customers.** The Stripe customer behind each account in your product, matched through the IDs you already store.
- **Events.** What Stripe sent to your webhooks and when, so a missing or repeated event can be found.

## What it does with it

1. **Checks the complaint.** It compares what your product recorded with what Stripe actually charged, for that customer first.
2. **Finds everyone affected.** It runs the same comparison across all accounts and returns the list, with the amount wrong for each.
3. **Finds the cause.** It reads the billing code, the recent pull requests and the webhook events, and points to the change that introduced the bug.
4. **Prepares the repair.** A pull request for the code, and a script for refunds or credits that a human reviews and runs.

## Finding everyone affected

Take case #4630. A customer of Planwerk, a German booking platform, wrote that their annual upgrade was billed at the monthly price. Deflekt checked the invoice in Stripe, then compared every subscription changed in the last six weeks with the plan stored in the application. It found 17 accounts with a proration on the wrong price, totalling €2,964.00, all created after one pull request that changed how upgrades were sent to Stripe. Sarah got a draft reply in German. Lina got a fix with a test and a script listing the 17 invoices to correct.

Deflekt never refunds, credits or cancels anything in Stripe. It prepares the script, and a person decides whether and when it runs.

## Setup

Deflekt is configured around how your product stores Stripe IDs.

1. In the Stripe dashboard, create a restricted API key.
2. Give it **Read** permission on Charges, PaymentIntents, Invoices, Subscriptions, Customers and Events, and **None** on everything else.
3. Paste the key in Deflekt. It is encrypted at rest and scoped to one project.
4. Tell Deflekt which column in your database holds the Stripe customer ID.

Deflekt only reads from Stripe. Read how it handles [payment bugs](/use-cases/payment-bugs/), follow the [double charge case file](/case-files/double-charge/), or see the [Mollie](/integrations/mollie/) connector.
