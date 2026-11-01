---
title: One complaint, thirty eight victims
kicker: Case 5172
date: 2026-10-26
order: 1
headline: One complaint, <em>thirty eight victims.</em>
description: A Dutch speaking customer wrote that he had been charged twice. Deflekt found thirty seven more who had not noticed yet, and everything was ready to approve nine minutes later.
facts:
  Product: Subscription SaaS, Belgium
  Signal: One ticket, in Dutch
  Found: 38 subscriptions, €4,218.40
  Time to answer: 9 minutes
---

Monday, 08:42. Pieter, a customer since 2021, writes in Dutch: *"Mijn abonnement is deze maand twee keer afgeschreven."* His subscription was charged twice this month.

## 08:43, the payments

Deflekt does not start with Pieter's account. It starts with the question behind the ticket: did this happen to anyone else? A read only query on the payment provider answers it. Thirty eight subscriptions were charged twice since Thursday evening, €4,218.40 in total. One complaint.

## 08:44, the cause

The double charges all started after a deploy on Thursday at 17:05. In that deploy, a refactor of the payment webhook handler dropped its idempotency key. The payment provider retries webhooks when it does not get a fast answer, and every retry created a new charge.

## 08:47, the answers

Instead of one reply, Deflekt prepared four things:

- A reply to Pieter in Dutch, in the team's voice, written in the future tense because nothing had been refunded yet.
- A refund script for the thirty eight duplicate payments, waiting for a human to run it.
- A short email for the thirty seven customers who had not noticed, explaining what happened and that the money would come back.
- A pull request restoring the idempotency key, with a regression test that replays the webhook three times.

## 08:51, the proof

The fix was run in two environments with the same data. Before, a replayed webhook charged twice. After, once. The recording was attached to the pull request.

## 08:56, the approval

Lina, the developer on duty, reviewed nine lines and approved. Support approved the reply and the emails. The refunds went out before 09:00.

> Nobody else had to write in.

## What was remembered

The next morning's brief summed it up for management, and Deflekt kept one lesson for every future case: the payment provider retries webhooks up to ten times, so every payment handler must be idempotent. The next pull request that touches one will be checked against it. See the [payment bugs use case](/use-cases/payment-bugs/).
