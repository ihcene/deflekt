---
title: Deflekt for Gitea
name: Gitea
kicker: Code and CI
order: 15
headline: Your code lives on your own Gitea. <em>Deflekt's fixes arrive there, and nothing else leaves.</em>
description: Deflekt reads your Gitea repositories, pull requests and issues, opens pull requests with tested fixes across several repositories, and answers review comments and failing Gitea Actions runs, all inside your network.
facts:
  Category: Code and CI
  Access: Scoped access token on a bot account
  Reads: Repositories, pull requests, issues, Actions runs
  Also: Works with Forgejo and self hosted instances
---

Teams that run Gitea usually chose it on purpose. The code stays on their own servers, often behind a VPN, and no outside service gets a copy. That is exactly the setup Deflekt was built for: the work that touches your code happens inside your network, and only the results come out.

## What Deflekt reads

- **Repositories.** The code at the commit running in production, across backend, frontend and mobile repositories.
- **Pull requests and reviews.** What shipped recently and what is in review, so a bug can be traced to the change that caused it.
- **Issues.** The tickets your team already tracks in Gitea, as context and as a place to file work that needs planning.
- **Gitea Actions runs.** The result of your workflows on every pull request Deflekt opens.

## What it does with it

1. **Traces the cause.** It matches a customer ticket or an error to the pull request that introduced it.
2. **Writes the fix** in each repository that needs a change, with a regression test.
3. **Proves it.** It runs your test suite and records the bug and the fix side by side in a real browser.
4. **Opens the pull requests** in Gitea, filled with your template and the recording.
5. **Handles review rounds.** Reviewer comments and failing Actions runs are answered with new commits until the pull request is ready to merge.

## A review round on Gitea

Case #5172 started with Pieter from Van Damme Bouw charged twice. Deflekt traced it to a webhook handler that lost its idempotency key, and opened PR #2231 on the team's Gitea with a 9 line fix and a test.

```
review on PR #2231 from lina: "log the idempotency key when we retry"
commit add idempotency key to retry log line
run    gitea actions: test 1,284 passed · lint failed
commit wrap long line in payment_webhook.rb
run    gitea actions: all checks passed
reply  "Done in 3f9c2e1, key is now in the retry log."
```

## Built for self hosted

Deflekt's workers run in the same network as your Gitea instance. They clone over your internal address, run the tests and record the QA there. Your Gitea does not need to be reachable from the internet, and source code never leaves your network. Only the results, the recording and the pull request links reach the hub, and credentials are encrypted at rest and scoped per project. Forgejo, the community fork of Gitea, works the same way.

## Setup

1. Create a bot user in Gitea and add it to the repositories Deflekt may work on.
2. Generate an access token for that user with read and write access to repositories and issues.
3. Add a webhook on the organization pointing at Deflekt, for pull request, issue and workflow run events.
4. Start a worker in your network and give it the internal URL of your Gitea instance.

Deflekt never merges. Every change is a pull request your team reviews. See the same flow on [GitHub](/integrations/github/) and [GitLab](/integrations/gitlab/), or read how it catches [regressions after a deploy](/use-cases/deploy-regressions/).
