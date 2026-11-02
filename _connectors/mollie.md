---
title: Deflekt for Mollie
name: Mollie
kicker: Payments
order: 12
headline: Mollie says what was paid. <em>Deflekt says what should have been.</em>
description: Deflekt reads Mollie payments, refunds, subscriptions and customers with read only access, checks them against your database, and turns one double charge complaint into the full list of accounts affected.
facts:
  Category: Payments
  Access: Read only access token
  Reads: Payments, refunds, subscriptions, customers
  Also: Webhook retries checked against your records
---

Payment bugs rarely announce themselves. A webhook arrives twice, a retry is treated as a new payment, and the first sign is a polite email from a customer who noticed. By then the same thing has happened to dozens of others.

## What Deflekt reads

- **Payments.** Amounts, statuses, methods, timestamps and the metadata your application attaches to each one.
- **Refunds.** What was already refunded, so a repair never pays someone back twice.
- **Subscriptions.** Intervals, amounts and next payment dates for every recurring customer.
- **Customers.** The Mollie customer behind each account in your product, matched through the IDs you already store.

## What it does with it

1. **Checks the complaint.** It compares the payments in Mollie with the invoices and subscriptions in your database for that customer.
2. **Finds everyone affected.** It runs the same check across all accounts and lists each one with the amount involved.
3. **Finds the cause.** It reads the webhook handler, the recent pull requests and the payment history, and points to the change that broke it.
4. **Prepares the repair.** A pull request for the code and a refund script that a human reviews and runs. Deflekt never refunds on its own.

## Webhook retries and case #5172

Mollie calls your webhook again when your endpoint does not answer in time or returns an error. Your code has to recognise a retry and do nothing the second time. In case #5172, it stopped doing that. Pieter from Van Damme Bouw, a customer since 2021, wrote in Dutch that he had been charged twice. Deflekt matched his payments in Mollie with the subscriptions in the database, then ran the same check on every account. It found 38 subscriptions charged twice, €4,218.40 in total, all after PR #2214, where the webhook handler lost its idempotency key during a refactor.

Lina received fix PR #2231, nine lines with a test that replays a retried webhook, and a refund script listing the 38 payments. Sarah received a draft reply to Pieter in Dutch. Marc read the impact in the morning briefing. Nothing was refunded until Lina ran the script herself.

## Setup

1. In Mollie, create an organization access token with read scopes only: `payments.read`, `refunds.read`, `subscriptions.read` and `customers.read`.
2. Paste the token in Deflekt. It is encrypted at rest and scoped to one project.
3. Tell Deflekt which column in your database holds the Mollie customer or payment ID.
4. Ask a first question, such as "which customers were charged twice last month", to check the connection.

Deflekt only reads from Mollie. Follow the full [double charge case file](/case-files/double-charge/), read how it handles [payment bugs](/use-cases/payment-bugs/), or compare with the [Stripe](/integrations/stripe/) connector.
