# Modes

Modes change **where you stop and who acts**. They never change the rest of the contract:
every mode still verifies effects rather than status codes, reports failures and mistakes
immediately, writes records as it goes, and marks ownership.

The default is **standard**. The user picks another mode with the skill argument
(`/checkpointed-execution strict`) or in plain words ("go lighter on the stops", "I want to
do the steps myself"). They can switch at any point, including for a single step
("strict for step 4").

## Always stop, in every mode

Whatever the mode or batch approval, stop immediately when:

- a step fails, or its verification does not match what was expected;
- something surprising happens, even if the step looks like it succeeded;
- you made a mistake, or are about to act on an assumption you have not tested;
- the next action is irreversible, destructive, or reaches outside the agreed scope
  (deleting data, overwriting shared config, sending anything to an external system).

## lite

Stop at **phase boundaries** instead of after every step. A phase is a group of steps the
plan names together, such as "provision", "configure", "verify end to end".

- Inside a phase, run the steps back to back, verifying each one as you go.
- At the end of the phase, report each step in one or two lines with its evidence, then stop.
- Use it when the user knows the territory and wants fewer interruptions, or when the steps
  inside a phase are cheap to redo.

## standard

Stop after **every step**. This is the behaviour described in the main skill file.

- Use it by default, and whenever state is cumulative and a wrong step is expensive to unwind.

## strict

Standard, plus **show before you write**. Before any `[ME]` action that changes state, show
the exact command, request, or edit, and wait for approval. Then run it, verify it, and
report as usual.

- Read-only actions (listing, querying, reading files) do not need advance approval.
- Use it for production, shared environments, customer systems, or anything where one bad
  write is a real incident.

## hands-on

The user does the work; you guide and check it. Every action that changes state defaults to
`[YOU]`.

- For each step, explain what it does and why, then give the exact commands or values and
  the output the user should expect.
- After the user reports back, verify the result yourself with read-only checks, and say
  plainly what matched and what did not.
- Never perform a `[YOU]` action yourself, even when it would be faster. If the user asks you
  to take one over, mark it `[ME]` and say so.
- Use it when the user is learning, or will operate the system themselves later.

## Showing the mode

Include the mode in every status line, so the user can see which rules are in force:

> ⏸ Checkpoint 3/7 · strict — next: apply the access policy. Reply **go** to continue.
