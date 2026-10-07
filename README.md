# checkpointed-execution

**200 OK is not done.**

An agent skill that runs multi-step work as a sequence of reviewed checkpoints. After each step the agent reports what it did and the evidence that it worked, then stops and waits for your confirmation before starting the next one.

- **Stop after every step.** The next step starts only when you say so.
- **Verify effects, not status codes.** Read back what was written; don't trust a `201 Created`.
- **Mark ownership.** `[ME]` for agent actions, `[YOU]` for yours, with exact values.
- **Write the runbook as you go.** Every session leaves a document someone else can follow.

## Install

```sh
npx skills add pabasara-mahindapala/checkpointed-execution -g
```

<details>
<summary>Other install methods</summary>

**Claude Code plugin**

```sh
claude plugin marketplace add pabasara-mahindapala/checkpointed-execution
claude plugin install checkpointed-execution@checkpointed-execution
```

**Manual**

```sh
cp -r skills/checkpointed-execution ~/.claude/skills/   # or ~/.agents/skills/
```

</details>

## Use

Say "one step at a time", "stop and let me review", or "walk me through it", or invoke `/checkpointed-execution`.

## License

MIT
