---
title: Deflekt for GitHub
name: GitHub
kicker: Code and CI
order: 4
headline: Your code lives on GitHub. <em>Deflekt's fixes arrive there, tested and ready to review.</em>
description: Through a GitHub App, Deflekt reads your repositories and pull requests, opens pull requests across several repositories, fills your template, handles review rounds and embeds the QA recording.
facts:
  Category: Code and CI
  Access: GitHub App, live today
  Reads: Repositories, pull requests, reviews, CI checks
  Also: Browser extension panel on pull requests
---

A fix for a support ticket is often nine lines of code and two hours of everything around it: reproducing the bug, writing the test, filling the template, recording a demo for the reviewer, then fixing the CI check that failed for an unrelated reason. That surrounding work is what Deflekt takes on.

## What Deflekt reads

- **Repositories.** The code at the commit that is running in production, across backend, frontend and mobile.
- **Pull requests.** What shipped recently and what is in review, so a bug can be traced to the change that caused it.
- **Reviews and comments.** What your reviewers ask for, on its own pull requests and as context for the team's conventions.
- **CI checks.** The results of your workflows on every pull request it opens.

## What it does with it

1. **Traces the cause.** It matches a ticket or an error to the pull request that introduced it.
2. **Writes the fix** in each repository that needs a change, with a regression test.
3. **Proves it.** It runs your test suite and records the bug and the fix side by side in a real browser.
4. **Opens the pull requests.** It fills your pull request template and embeds the QA recording so reviewers can watch it play.
5. **Handles review rounds.** Reviewer comments and failing CI checks are answered with new commits until the pull request is ready to merge.

## A review round

Case #5172 started with Pieter from Van Damme Bouw charged twice. Deflekt traced it to PR #2214, where a webhook handler lost its idempotency key, and opened PR #2231 with a 9 line fix and a test. Lina asked for the key to be logged on retries.

```
review on PR #2231 from lina: "log the idempotency key when we retry"
read   app/webhooks/mollie_handler.rb
commit add idempotency key to retry log line
run    test suite: 1,284 passed
check  ci/lint failed: line too long, fixed in follow up commit
reply  "Done in 3f9c2e1, key is now in the retry log."
```

Lina approved, and the team merged.

## Your code stays in your network

Deflekt's workers run inside your own network. They clone your repositories, run the tests and record the QA there, so source code never leaves it. The hub only receives the results.

## Setup

1. Install the Deflekt GitHub App on your organization and select the repositories it may access.
2. The App asks for read access to metadata and checks, and read and write access to contents and pull requests so it can push branches and open pull requests.
3. Start a worker in your network and connect it to your Deflekt project.
4. Install the browser extension to see the Deflekt analysis on each pull request.

Deflekt never merges. Every change is a pull request your team reviews. See how it catches [regressions after a deploy](/use-cases/deploy-regressions/), how it fits next to [coding agents](/compare/coding-agents/), or read the [double charge case](/case-files/double-charge/).
