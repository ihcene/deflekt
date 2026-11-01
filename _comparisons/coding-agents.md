---
title: Deflekt vs coding agents
kicker: Claude Code, Codex, Cursor, Devin
order: 3
headline: Coding agents build what you decided. <em>Deflekt decides what needs building.</em>
description: Coding agents help a developer who already knows what to build. Deflekt works before that point. It takes requests from anyone, investigates in code and data, and decides whether the answer is a reply, a command or a change.
facts:
  Category: AI coding agents
  Also applies to: Claude Code, Codex, Cursor, Devin
  Works together: Yes, Deflekt can drive them and check the result
---

Claude Code, Codex, Cursor and Devin are very good at writing code. Give them a clear task and a repository, and they produce a working change, often in minutes. They are built for a developer who has already decided what to build.

Most of the work around a live product does not arrive like that. It arrives as a ticket in French, a Sentry issue nobody owns, a question from sales, a number in a dashboard that looks wrong. Before any code is written, someone has to work out what the request really is. Often the answer is not code at all.

## Side by side

| | Coding agents | Deflekt |
|---|---|---|
| Who asks | A developer, in the editor or terminal | Anyone: customers, support, sales, the error tracker, the data |
| Starting point | A task that is already defined | A raw request that still needs investigating |
| Looks at | The repository | Code, production data (read only), tickets, deploys, customer history |
| Typical outcome | A code change | A reply, a console command, or a fix, whichever is right |
| Proof | Tests, if asked | Test suite plus bug and fix recorded side by side on the same data |
| Remembers | Session or project context | Every case, every customer, every correction from the team |

## When to use which

**Use a coding agent** when you know what you want and you want it written. Refactors, new endpoints, migrations, test coverage: that is their home.

**Use Deflekt** when you do not know yet. A support agent forwards a ticket: a customer says his credit note has the wrong number. Deflekt reads the account, finds the credit note was created by hand through the API with a custom number, and sees the code behaves as designed. The answer is a reply explaining it, not a pull request. The next request is a real bug, and the answer is a nine line fix. Deciding which is which is the job.

## Together

Deflekt sits upstream of these tools, not against them. When the answer is a change, Deflekt can hand the task to the same coding agents your team already uses, with the context it gathered: the customer, the data, the cause, the test to write. Then it checks the result, runs both versions side by side and puts the recording in the pull request before a developer reviews it. Engineers can also query Deflekt from their own AI tools through its MCP server.

Deflekt can build features as well, and it will. But most of the value is earlier, in the hours spent finding out what a request means. See how it handles [feature requests](/use-cases/feature-requests/) and [product questions](/use-cases/product-questions/), and how it works with [GitHub](/integrations/github/).
