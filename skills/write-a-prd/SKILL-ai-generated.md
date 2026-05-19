---
name: write-a-prd
description: "Create a PRD through user interview, codebase exploration, and module design, then submit as a GitHub issue. Use when user wants to write a PRD, create a product requirements document, or plan a new feature."
argument-hint: "Feature/idea + context (links, constraints, audience)"
user-invocable: true
---

# Write a PRD (Lean)

## What this skill produces

A Lean PRD in Markdown that is suitable for sharing in an issue/PR description or saving as a `docs/` file. It emphasizes clarity, testable requirements, measurable success metrics, and safe rollout.

## When to use

Use this skill when you need a:

- PRD / spec / RFC / feature proposal / one-pager expansion
- Requirements doc with acceptance criteria
- Alignment artifact for stakeholders (product, design, engineering)

Trigger keywords for discovery: PRD, requirements, product spec, RFC, proposal, acceptance criteria, success metrics, rollout plan.

## Default format

Use the Lean template: [./assets/lean-prd-template.md](./assets/lean-prd-template.md)

## Procedure

1. **Clarify the ask (audience + decision needed).**
   - Who is this for (execs, PMs, eng, support)?
   - What decision should readers be able to make after reading?

2. **Gather context (lightweight).**
   - Current behavior / baseline and what is broken or missing
   - Constraints: platform, tech, performance, cost, legal/compliance
   - Links: issue(s), designs, prior docs, analytics, customer feedback

3. **Write the Problem + Why now.**
   - 1–3 short paragraphs, user-centric.
   - If info is missing, write **assumptions** explicitly and list **open questions**.

4. **Define Goals and Non-goals.**
   - Goals must be measurable or at least falsifiable.
   - Non-goals prevent scope creep (be explicit).

5. **Describe users and primary use-cases.**
   - Who benefits and how?
   - Include the core “happy path” and any critical edge cases.

6. **Propose the solution (conceptual).**
   - Describe what changes for the user.
   - If there are multiple plausible approaches, include **Options & Tradeoffs** and recommend one.

7. **Specify requirements (testable).**
   - Prefer **Must / Should / Could** buckets.
   - Add acceptance criteria that can be verified.
   - Call out error states, empty states, permissions, and backwards-compatibility.

8. **Define success metrics + instrumentation.**
   - What will you measure? Where will the data come from?
   - Include guardrails (e.g., latency, error rates, support tickets).

9. **Risks and mitigations.**
   - Product risk, technical risk, operational risk, privacy/security risk.

10. **Rollout plan (phased, safe).**

- Feature flags, staged rollout, migration/backfill (if any), rollback strategy.

11. **Finish with open questions and decision log.**

- Make it easy for reviewers to unblock you.

## Decision points / branching

- **If requirements are unclear:** capture assumptions + top questions; propose a small discovery step.
- **If impact is high (privacy/security/compliance):** add a dedicated considerations section and flag stakeholders.
- **If solution touches code/architecture:** include a short “Technical Notes” section (keep it high level).
- **If scope seems big:** propose a phased plan with an MVP slice.

## Quality checklist (done criteria)

- Problem statement is crisp and user-centered.
- Goals are measurable/falsifiable; non-goals are explicit.
- Requirements are testable and include key edge cases.
- Metrics include instrumentation and guardrails.
- Rollout plan includes rollback and operational considerations.
- Open questions are actionable (owner/decision needed when possible).

## Optional: saving the PRD to a file

If the user provides a desired path, create or update that file with the generated PRD (Markdown). If no path is provided, output the PRD in chat.
