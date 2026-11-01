---
title: Deflekt for Intercom
name: Intercom
kicker: Help desk and chat
order: 6
headline: Fin answers what the docs can. <em>Deflekt answers what only the code knows.</em>
description: Deflekt reads Intercom conversations, contacts and companies, picks up what Fin hands over to your team, and investigates it in your code and data before drafting the reply.
facts:
  Category: Help desk and chat
  Access: Intercom access token, built during onboarding
  Reads: Conversations, contacts, companies
  Also: Picks up conversations escalated by Fin
---

Intercom makes it easy for customers to write, and Fin answers a good share of them from your help center. The conversations left over are the hard ones: a payment that looks wrong, an import that stopped halfway, a number that does not match. Those land in the team inbox, and someone has to go and find out.

## What Deflekt reads

- **Conversations.** Every message and note, including the part handled by Fin and the moment it handed over.
- **Contacts.** Who is writing, their attributes, and their earlier conversations.
- **Companies.** The account behind the contact, its plan and custom attributes, so Deflekt checks the right data in your product.
- **Attachments.** Screenshots and files shared in the chat.

## What it does with it

1. **Picks up the handover.** When Fin escalates, Deflekt starts the investigation before an agent has opened the conversation.
2. **Investigates in code and data.** It reads the code, recent deploys, the error tracker and the company's records, read only.
3. **Drafts the reply** in the customer's language and your team's tone, or a note for the team when an answer has to wait.
4. **Prepares the fix** when there is one, as a console command or a pull request tested side by side.
5. **Waits for approval** before anything is posted in the conversation.

## Working with Fin

Deflekt does not replace Fin. Fin handles the questions your documentation already answers. Deflekt handles what Fin escalates, the questions that need someone to look at the code and the data. In case #5310, Camille from Atelier Morel asks in French why her booking reminders went out a day late. Fin finds no article and hands over. Deflekt finds a time zone conversion added in a recent release, checks the reminders sent that week, and gives the agent a French reply plus a pull request with the fix.

## Built during onboarding

The Intercom connector is built with you during onboarding, usually within days, on the public Intercom API. It follows your team inboxes and assignment rules rather than adding a new workflow. Your agents keep working in Intercom, and Deflekt's draft is waiting in the conversation when they open it.

## Setup

1. In the Intercom Developer Hub, create a private app for your workspace and copy its access token.
2. Grant it permission to read conversations, read users and companies, and write conversations so approved replies can be posted.
3. Subscribe the app's webhooks to new conversations, customer replies and assignments, pointing at Deflekt.
4. Choose the team inboxes Deflekt should watch.

Replies are drafts until an agent approves them. To see where Fin ends and Deflekt starts, read [Deflekt and Intercom Fin](/compare/intercom-fin/), or how it answers [product questions](/use-cases/product-questions/).
