---
title: Deflekt for Jira
name: Jira
kicker: Issue tracker
order: 5
headline: Jira tracks the work. <em>Deflekt makes sure the right work gets there.</em>
description: Deflekt reads Jira issues, comments, linked tickets and sprint context, investigates each bug in your code and data, and drafts a clear issue when it finds engineering work that needs planning.
facts:
  Category: Issue tracker
  Access: Jira API token
  Reads: Issues, comments, linked tickets, sprint context
  Also: Browser extension panel on Jira issues
---

A Jira backlog fills up with tickets that say "export broken for some customers" and little else. Before anyone can estimate them, a developer has to reproduce the problem, find the accounts involved and work out whether it is one bug or three. That triage rarely fits in a sprint.

## What Deflekt reads

- **Issues.** Summary, description, status, priority, labels, components and attachments.
- **Comments.** What has been tried, what the reporter added, what a reviewer asked.
- **Linked tickets.** Duplicates, blockers and the support tickets that point to the same problem.
- **Sprint context.** Whether the issue is planned, in the current sprint or waiting in the backlog.

## What it does with it

1. **Investigates the issue.** It reads the code, recent pull requests and deploys, Sentry and the data involved, read only.
2. **Adds what was missing.** The affected accounts, the likely cause, the steps to reproduce and a priority based on evidence.
3. **Spots duplicates.** Issues with the same root cause are linked into one case.
4. **Proposes the fix** as a pull request tested side by side, when the change is small enough to review.
5. **Drafts an issue** when the work needs planning, ready for your team to create.

## From support to engineering

Not every case ends in a nine line fix. In case #4712, three customers of a bookings product report that recurring appointments skip the last week of the month. Deflekt traces it to the way recurrence rules are stored and sees that the fix touches the data model. Instead of a rushed patch, it drafts a Jira issue with the cause, the 41 affected series, the code involved and a proposed approach, linked to the three support tickets. Lina reviews it, adjusts the estimate and adds it to the next sprint.

## Inside Jira

With the Deflekt browser extension, a panel appears on each Jira issue with the investigation, the evidence and any proposed fix. The analysis sits next to the issue, where the team already discusses it. Reviewers can see why a fix was proposed before they open the pull request.

## Setup

1. Create an Atlassian account for Deflekt with Browse projects permission on the projects to watch, and generate an API token for it.
2. Paste your site URL, the account email and the token in Deflekt.
3. Choose the projects or a JQL filter that defines which issues Deflekt investigates.
4. Optionally, add a Jira webhook for issue created and comment created events so new issues are picked up at once.

Deflekt does not move, assign or close Jira issues on its own, and drafted issues are only created once someone approves them. See how it handles [feature requests](/use-cases/feature-requests/), or pair it with [GitHub](/integrations/github/) for the fixes.
