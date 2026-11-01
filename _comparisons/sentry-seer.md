---
title: Deflekt vs Sentry Seer
kicker: Error autofix
order: 2
headline: Seer starts from the error. <em>Deflekt starts from the request.</em>
description: Sentry Seer analyzes an error and suggests a fix from its context. Deflekt starts from any request, links it to customers, reads production data, proves the fix side by side and prepares the reply.
facts:
  Category: AI error autofix
  Also applies to: Error tracker assistants
  Works together: Yes, Deflekt reads the same Sentry issues
---

Sentry Seer is the AI built into Sentry. It looks at an issue with everything Sentry already knows about it, the stack trace, the events, the surrounding context and the connected code, and suggests a root cause and a fix. When a problem throws an exception, that is a strong place to start.

Many of the problems that cost the most never throw anything. A customer writes that his invoice shows last month's VAT rate. A nightly job runs fine and writes nothing. Someone in sales asks whether a feature exists at all. None of those reach an error tracker, and the ones that do still raise questions Seer is not built to answer: which customers were affected, what do we tell them, and does the fix actually change what they see.

## Side by side

| | Sentry Seer | Deflekt |
|---|---|---|
| Starts from | A Sentry issue | Any request: tickets, Sentry issues, data anomalies, questions from the team |
| Looks at | Error context and code | Code, recent deploys, production data (read only), customer history |
| Customers | Not its focus | Linked to the request, affected accounts found in the data |
| Proof | Suggested fix | Fix run against the same data with and without the bug, recorded in a browser |
| Customer reply | Not its job | Drafted in the customer's language, waiting for approval |
| Problems with no error | Out of scope | Found by Data Watch in the product's own database |

## When to use which

**Use Seer** when your team lives in Sentry and wants a fast first opinion on an exception, right where the issue is triaged. It is close to the error and that is its strength.

**Use Deflekt** when the question is bigger than the exception. Take a Sentry issue about a failing PDF render. Deflekt reads the stack trace, then checks the database: forty two invoices in the last week could not be generated, eleven customers are behind them, and two of those customers already opened a ticket. It prepares a pull request, runs the bug and the fix side by side on the same data, records both, and drafts the two replies. Nothing goes out until someone on the team approves it.

## Together

They do not compete for the same moment. Seer helps a developer understand an error inside Sentry. Deflekt picks up the same issue and connects it to the rest of the product: the tickets, the accounts, the data and the people waiting for an answer. Many teams will keep both. Deflekt reads issues, events and stack traces through the [Sentry integration](/integrations/sentry/), and the [deploy regressions use case](/use-cases/deploy-regressions/) shows a full investigation. For problems that never raise an error, see [silent data bugs](/use-cases/silent-data-bugs/).
