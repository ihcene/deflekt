---
title: Deflekt for GitLab
name: GitLab
kicker: Code and CI
order: 7
headline: Your code lives on GitLab. <em>Deflekt sends its fixes as merge requests, tested and recorded.</em>
description: Deflekt reads your GitLab projects and merge requests, opens merge requests with tested fixes across several projects, and answers review comments and failing pipelines until they are ready to merge.
facts:
  Category: Code and CI
  Access: Project access tokens
  Reads: Projects, merge requests, discussions, pipelines
  Also: Recording of the fix embedded in each merge request
---

Teams on GitLab, often self managed, want the same thing as everyone else: fewer hours spent on the work around a small fix. Reproducing the bug, writing the test, filling the template, recording a demo and chasing a red pipeline take longer than the change itself.

## What Deflekt reads

- **Projects.** The code at the commit running in production, across backend, frontend and mobile projects.
- **Merge requests.** Recent and open merge requests, so a bug can be traced to the change that caused it.
- **Discussions.** Review threads and comments, on its own merge requests and as context for your conventions.
- **Pipelines.** GitLab CI results on every merge request it opens.

## What it does with it

1. **Traces the cause** of a ticket or error to the merge request that introduced it.
2. **Writes the fix** in each project that needs a change, with a regression test.
3. **Proves it.** It runs your test suite and records the bug and the fix side by side in a real browser.
4. **Opens the merge requests.** It fills your merge request template and embeds the QA recording.
5. **Handles review rounds.** Unresolved threads and failed pipeline jobs are answered with new commits.

## Pipelines and review rounds

Case #4925: an invoicing product starts rounding VAT per line instead of per invoice after a release, and a Belgian customer notices a one cent difference on 112 invoices. Deflekt finds the change in a merge request from the week before, opens a fix in the backend project and a matching change in the PDF rendering project. The first pipeline fails on a snapshot test that still expects the old rounding. Deflekt updates the snapshot, explains why in the thread, and the pipeline goes green before a reviewer has looked.

## gitlab.com or self managed

Deflekt works on the GitLab REST API, with gitlab.com and with self managed instances your workers can reach. Workers clone the code inside your network, so source code never leaves it. Only the results, the recording and the merge request links reach the hub, and credentials are encrypted at rest and scoped per project.

## Setup

1. In each project, create a project access token with the Developer role and the `api`, `read_repository` and `write_repository` scopes.
2. Paste the tokens and your GitLab URL in Deflekt.
3. Add a project webhook for merge request, comment and pipeline events, pointing at Deflekt.
4. Start a worker in your network and connect it to your Deflekt project.

Deflekt never merges or pushes to protected branches. Every change is a merge request your team reviews. Compare it with [GitHub](/integrations/github/) and [Gitea](/integrations/gitea/), or read how it handles [regulatory changes](/use-cases/regulatory-changes/).
