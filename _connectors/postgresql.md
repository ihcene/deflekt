---
title: Deflekt for PostgreSQL
name: PostgreSQL
kicker: Data
order: 8
headline: The answer is usually in your database. <em>Deflekt reads it, and never writes.</em>
description: Deflekt connects to PostgreSQL with a dedicated read only role, ideally on a replica, so every investigation can check real data and Data Watch can catch silent bugs every night.
facts:
  Category: Data
  Access: Dedicated read only role, ideally on a replica
  Reads: Tables your role is allowed to select
  Also: Nightly Data Watch probes
---

Most support questions end with someone opening a database console. Is this invoice really unpaid? When did this account stop syncing? How many other customers are in the same state? The developer on duty stops what they are doing, writes a query, and pastes the result in a chat. Deflekt does that part itself, with access that cannot change anything. The PostgreSQL connector is live today.

## What Deflekt reads

- **The rows behind a ticket.** The customer's account, records, statuses and timestamps, so a reply is based on facts and not on the customer's description.
- **The schema.** Tables, columns, constraints and indexes, matched with the models in your code, so queries follow the relations your application actually uses.
- **Patterns across accounts.** How many other customers share the same broken state, which turns one ticket into a list of everyone affected.

## What it does with it

1. **Checks the facts during an investigation.** Each investigation session runs its queries with the read only role and cites them next to the conclusion.
2. **Measures the impact.** One report about a missing delivery note becomes "41 shipments since Tuesday have no note, across 9 accounts".
3. **Prepares the repair.** When data needs fixing, Deflekt writes the console command or the script and a human runs it after review.
4. **Watches every night.** Data Watch runs probes on the same connection: a feature that stops writing, a column that suddenly goes empty, a status nobody has seen before.

## How the access is built

Deflekt asks for a role that can only read, ideally on a replica so investigations never compete with your production traffic. Queries run from Deflekt workers inside your own network, and the credentials are encrypted at rest and scoped to one project. A typical role looks like this:

```sql
CREATE ROLE deflekt_readonly WITH LOGIN PASSWORD 'change-me';
GRANT CONNECT ON DATABASE app_production TO deflekt_readonly;
GRANT USAGE ON SCHEMA public TO deflekt_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO deflekt_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO deflekt_readonly;
ALTER ROLE deflekt_readonly SET default_transaction_read_only = on;
ALTER ROLE deflekt_readonly SET statement_timeout = '30s';
```

You can leave out tables Deflekt should never see by granting `SELECT` table by table instead of on the whole schema.

## Setup

1. Create the read only role on a replica, or on the primary if you have no replica.
2. Allow connections from the worker running inside your network.
3. Add the connection details in Deflekt and choose the schemas it may read.
4. Let Data Watch learn from your history, then review the rules it proposes before they run every night.

Deflekt never inserts, updates or deletes, and every repair waits for a human. Read how it catches [silent data bugs](/use-cases/silent-data-bugs/), follow the [silent export case file](/case-files/silent-export/), or use [Metabase](/integrations/metabase/) instead of a direct connection.
