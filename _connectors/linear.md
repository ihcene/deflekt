---
title: Deflekt for Linear
name: Linear
kicker: Issue tracker
order: 9
headline: Linear keeps the team fast. <em>Deflekt keeps the issues worth the speed.</em>
description: Deflekt reads Linear issues, projects and cycles, investigates bugs in your code and data, and drafts an issue with the cause and a proposed approach when a fix needs planning.
facts:
  Category: Issue tracker
  Access: Linear API key, built during onboarding
  Reads: Issues, projects, cycles, comments
  Also: Drafts issues for fixes that need planning
---

Linear is fast to write in, which is exactly why so many issues arrive with a title and nothing else. The team moves quickly through a cycle, then loses half a day on an issue that turns out to be a duplicate, or a data problem on one account, or not a bug at all.

## What Deflekt reads

- **Issues.** Title, description, state, priority, labels, assignee and attachments.
- **Comments.** The discussion on each issue, so the investigation builds on what is known.
- **Projects.** Which larger piece of work an issue belongs to.
- **Cycles.** What is planned for the current cycle and what is waiting.

## What it does with it

1. **Investigates the issue.** It reads the code, recent pull requests and deploys, the error tracker and the data involved, read only.
2. **Adds the evidence.** Affected accounts, the likely cause, how to reproduce, and a priority based on impact.
3. **Proposes a fix** as a pull request tested side by side, when the change is small.
4. **Drafts an issue** when the fix needs planning, with the cause, the scope and a suggested approach.
5. **Waits for approval** before creating or updating anything in Linear.

## When a fix needs planning

Case #5568: a logistics customer reports in French that some shipments show the wrong carrier on the label. Deflekt finds that carrier codes are read from a cached table that is never refreshed when a carrier changes its code. A quick patch would hide it for one account. Instead, Deflekt drafts a Linear issue in the right team: the cause, the 63 shipments affected since the last carrier update, the files involved and a proposal to refresh the cache on change. The engineering lead attaches it to the current project and plans it for the next cycle.

## Built during onboarding

The Linear connector is built with you during onboarding, usually within days, on the Linear GraphQL API. It respects your teams, workflow states and labels rather than adding its own. Drafted issues use your existing labels and land in the team that owns the code involved, so nothing needs to be triaged twice.

## Setup

1. In Linear, open Settings and create a personal API key under API, from an account that has access to the teams Deflekt should see.
2. Paste the key in Deflekt and choose the teams to watch.
3. Optionally, a workspace admin adds a webhook for issue and comment events so new issues are picked up at once.
4. Choose who can approve issues drafted by Deflekt.

Deflekt only creates issues in Linear after someone approves them. Read how it turns requests into planned work in [feature requests](/use-cases/feature-requests/), or compare it with [Jira](/integrations/jira/).
