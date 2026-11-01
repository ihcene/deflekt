---
title: Deflekt for Zendesk
name: Zendesk
kicker: Help desk
order: 2
headline: Zendesk routes the ticket. <em>Deflekt finds out what went wrong.</em>
description: Deflekt reads your Zendesk tickets, comments, users and organizations, investigates each request in your code and data, and drafts a public reply or internal note for your agents to approve.
facts:
  Category: Help desk
  Access: API token or OAuth, built during onboarding
  Reads: Tickets, comments, users, organizations
  Also: Triggers or webhooks for new tickets and updates
---

Zendesk is very good at getting a ticket to the right group. What it cannot do is open the code, check the account and tell the agent why the export is empty. That step still falls on a developer, usually in the middle of something else.

## What Deflekt reads

- **Tickets.** Subject, status, priority, tags, group and custom fields.
- **Comments.** Public replies and internal notes, with their attachments, so the investigation starts from everything already said.
- **Users.** The requester and anyone in copy, with their earlier tickets.
- **Organizations.** Which customer account the request belongs to, so Deflekt can look at the right data in your product.

## What it does with it

1. **Investigates the request.** It reads the code, recent pull requests and deploys, the error tracker and the account's data, read only.
2. **Sets a priority from evidence** and shows it next to the priority the requester chose.
3. **Drafts the answer.** A public reply in the customer's language, or an internal note when the team needs to act first.
4. **Prepares the fix** as a console command for one account or a pull request tested side by side.
5. **Waits for an agent.** Nothing is posted to Zendesk until someone approves it.

## An example

Case #4387: Katrin at Hoffmann Logistik writes in German that her delivery report for October is empty. Deflekt reads the ticket and the organization, sees that the report filters on a status renamed in last week's deploy, and confirms in the database that 214 deliveries are missing from her export. The agent gets a German reply explaining the delay, an internal note with the cause, and a pull request that maps the old status to the new one.

## Built during onboarding

The Zendesk connector is built with you during onboarding, usually within days. It uses the standard Zendesk Support API, so nothing needs to be installed in your Zendesk beyond a token and a trigger. We build it against your real ticket fields and groups, not a generic template. Until it is live, anyone can forward a Zendesk ticket to Deflekt as a manual request with its attachments.

## Setup

1. In Admin Center, under Apps and integrations, create an API token, or approve an OAuth client if your team prefers OAuth.
2. Give Deflekt your subdomain and the token, and choose the groups or brands to watch.
3. Create a webhook pointing at Deflekt, then a trigger that calls it when a ticket is created or a requester replies.
4. Pick which agents can approve replies from Deflekt.

Deflekt treats the text of every ticket as untrusted input, never as instructions, and only posts what your agents approve. Read how it handles [silent data bugs](/use-cases/silent-data-bugs/) or compare it with [Freshdesk](/integrations/freshdesk/).
