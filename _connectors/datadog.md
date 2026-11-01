---
title: Deflekt for Datadog
name: Datadog
kicker: Monitoring
order: 10
headline: Datadog tells you a monitor fired. <em>Deflekt tells you which customers felt it.</em>
description: Deflekt reads your Datadog monitors, logs and APM traces with read only keys, links each alert to the customers and tickets behind it, and turns a noisy alert into one investigation with an answer.
facts:
  Category: Monitoring
  Access: Read only API and application keys
  Reads: Monitors, logs, APM traces
  Also: Alerts linked to customers and tickets
---

A monitor turns red at 02:14, recovers at 02:31, and everyone agrees to look at it in the morning. By then three customers have written to support about failed exports, and nobody connects the tickets to the alert. Datadog has the evidence. What is missing is the link between a graph and a person.

## What Deflekt reads

- **Monitors and their history.** Which monitors fired, when, for how long, and how often they have fired before.
- **Logs.** The log lines around an alert, filtered by service, environment and the account or user identifiers your application already writes.
- **APM traces.** Slow and failing requests, the endpoint involved, the spans that took the time and the error attached to them.
- **Tags.** Service, version and environment tags, so an alert can be matched with the deploy that shipped just before it.

## What it does with it

1. **Links alerts to customers.** An `export-worker error rate above 5%` monitor becomes "Transport Hendrickx and two other accounts hit this, and two of them have open tickets".
2. **Joins the tickets.** Tickets that arrive during or after the alert are attached to the same case instead of being investigated one by one.
3. **Finds the cause.** It follows the failing trace into the code, checks the pull requests in the release that the version tag points to, and queries the data involved, read only.
4. **Hands over the answer.** A draft reply for each affected customer, a console command when one account needs repair, or a pull request with a test when the code is at fault.

## From alert to case

Take case #4871. A latency monitor on the invoice PDF service fired twice in one night. Deflekt matched the slow traces to a query added in a pull request merged that afternoon, found the four accounts whose requests timed out in the logs, and found two Freshdesk tickets from those accounts about blank invoices. Lina opened one case in the morning with the cause, the customers, two draft replies in Dutch and French, and a fix ready to review. The monitor itself stayed untouched.

## Setup

The Datadog connector is built during onboarding, usually within days, against your own account and the way your services are tagged.

1. Create an API key and an application key in Datadog for a dedicated service account.
2. Scope the application key to read permissions only, such as `monitors_read`, `logs_read_data` and `apm_read`.
3. Paste both keys in Deflekt, pick your Datadog site, and choose the services and monitors to follow.
4. Optionally, add a Datadog webhook to the monitors that matter so Deflekt starts investigating the moment they fire.

Deflekt never mutes, edits or resolves monitors, and it never acts on production alone. See it next to [Sentry](/integrations/sentry/) for application errors, or read how it handles [regressions after a deploy](/use-cases/deploy-regressions/).
