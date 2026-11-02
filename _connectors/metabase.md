---
title: Deflekt for Metabase
name: Metabase
kicker: Data
order: 13
headline: No direct database access? <em>Deflekt can work through Metabase.</em>
description: Deflekt uses the Metabase API with a dedicated account limited to the right collections and databases, so investigations and Data Watch can read your data without a new database connection.
facts:
  Category: Data
  Access: Dedicated Metabase account, limited permissions
  Reads: Saved questions, collections, databases you allow
  Also: Data Watch through Metabase
---

Some teams do not want another tool holding database credentials. Their data already sits behind Metabase, with permissions, groups and an audit trail they trust. For them, Deflekt reads through Metabase instead of connecting to the database directly. Deflekt gets the same view of the data that your analysts already have, no more.

## What Deflekt reads

- **The databases you allow.** Native or query builder access, only on the databases and schemas granted to Deflekt's group.
- **Saved questions.** The questions your team already trusts, such as "unpaid invoices by account" or "shipments without a carrier".
- **Collections.** Only the collections you share with Deflekt, so finance dashboards or HR reports stay out of reach.

## What it does with it

1. **Answers the ticket with real data.** A customer asks why their credit note is missing. Deflekt checks the records through Metabase and cites the query next to its answer.
2. **Reuses your definitions.** When a saved question already defines "active customer" or "overdue invoice", Deflekt uses it instead of guessing.
3. **Counts everyone affected.** One complaint becomes a list of the accounts in the same state, ready for support to contact.
4. **Runs Data Watch.** The nightly probes can run through Metabase: a feature that stops writing, a column that suddenly goes empty, a status nobody has seen before.

## Permissions that stay in Metabase

Every query Deflekt runs goes through the Metabase API as its own account, so the permissions you already manage in Metabase apply. Take case #5390: Sarah received a ticket from Atelier Moreau, a French speaking customer, saying their March bookings had disappeared from the export. Deflekt ran the team's saved question on bookings by account, saw the bookings were there with a status the export ignored, and found two other accounts in the same situation. Sarah got a draft reply in French and Lina got a short pull request. The Metabase account never saw more than the bookings collection and the application database, and every query it ran is visible in Metabase like any other user's.

## Setup

1. Create a group in Metabase for Deflekt and give it access only to the collections and databases it needs.
2. Create a dedicated account or an API key in that group.
3. Add the Metabase URL and the credentials in Deflekt. They are encrypted at rest and scoped to one project.
4. Choose whether Data Watch should run through Metabase, then review the rules it proposes.

Deflekt only reads through Metabase. It does not edit questions, dashboards, collections or permissions, and every repair still waits for a human. Compare it with a direct [PostgreSQL](/integrations/postgresql/) connection, or read how it catches [silent data bugs](/use-cases/silent-data-bugs/).
