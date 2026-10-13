# Plan: <task name>

> **Ground rules.** Work runs one step at a time. After each step the agent reports what it
> did and the evidence that it worked, then stops. The next step starts only on the user's
> explicit go. Mode: **standard**. Status codes are not evidence; every step is verified by
> reading back its effect.

## Context

<Why this work is happening, what problem it solves, and what "done" looks like.>

## Established facts

| Fact | How it was verified |
|---|---|
| <fact> | <command, query, or document, and its result> |

**Assumptions (not yet verified):**

- <assumption> — tested in step <n>

## Current state

<What already exists, where, and in what condition.>

## Deliverables

- `<path>` — <what it is>
- Runbook: `<path>`

## Steps

| # | Step | Owner | Verification | Status |
|---|---|---|---|---|
| 0 | Preflight: confirm the environment matches this plan (read-only) | [ME] | <what is checked> | pending |
| 1 | <intent: what this step establishes> | [ME] | <how the effect is checked> | pending |
| 2 | <intent> | [YOU] | <what the user pastes back> | pending |

Status values: `pending`, `in progress`, `done`, `failed`, `skipped`. Update the row as soon
as a step finishes, before reporting it.

## Risks and things to watch

- <what is expected to go wrong, and how it would show up>

## Out of scope

- <what this work will not touch, named so silence is not mistaken for an oversight>

## Log

<One line per checkpoint: date, step, outcome, and anything that changed the plan.>
