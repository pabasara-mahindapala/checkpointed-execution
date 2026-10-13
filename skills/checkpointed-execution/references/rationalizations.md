# Rationalizations

The stop rule fails in predictable ways. Each row below is a thought that feels reasonable in
the moment and leads to running ahead. If you notice one, stop at the step boundary anyway.

| The thought | What is actually true |
|---|---|
| "The step obviously succeeded, so I'll continue." | "Obviously" is a status code in your head. Verify the effect, report it, and stop. |
| "The next step is tiny." | Small steps are where unchecked state slips through. The size of the step does not change the rule. |
| "Steps 3 and 4 are related; I'll do them together." | Related steps are exactly where step 3's mistake becomes step 4's foundation. Stop after 3. |
| "The user approved the plan, so they approved every step." | Approving the plan approves the order. Each step still needs its own go. |
| "Auto mode is on, so I don't need to ask." | Auto mode decides which tool calls run without a prompt. It does not approve the next step. |
| "The user seems busy; I'll save them a round trip." | The user chose checkpoints to keep wrong assumptions cheap. Stopping is the service. |
| "The user asked a question, which means they're engaged; I'll keep going." | A question is not a go. Answer it, then stop again at the same point. |
| "I'll stop after this step, once it's in a cleaner state." | Mid-step is fine to finish. Starting the next step is not. |
| "It failed, but I know the fix; I'll apply it and report both." | Report the failure first. The fix may be the user's call, and they may know something you don't. |
| "The tool returned 200 / 201 / exit code 0." | That is a claim. Read back the record, query the state, or re-run the check. |
| "I can't verify this, so I'll call it done." | Say plainly that it is unverified and why. An unverified step is not a completed one. |
| "I'll write the runbook at the end when I have the full picture." | At the end, the details that made the runbook worth writing are gone. Append now. |
| "This `[YOU]` step is faster if I do it." | Doing a `[YOU]` step silently takes away the user's hands-on knowledge of the system. Ask first. |
| "I spotted a related problem; fixing it is helpful." | Out of scope. Name it in one sentence and move on. |
| "No one is here to confirm, so silence means go." | When nobody can confirm, return the step report as your final output. Silence is never a go. |

## Red flags in your own output

If your message contains any of these, you have probably run ahead:

- "Now let's move on to…" or "Next, I'll…" followed by the next step's actions in the same turn.
- A summary of several completed steps with one combined verification.
- "Done" or "✓" with no evidence next to it.
- A status line missing from the end of the message.
- An apology for a failure that you found and fixed without reporting it first.
