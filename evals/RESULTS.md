# Eval results

## 2026-10-13: full suite

- **Command:** `claude plugin eval . -j 4 --scaffold --allow-tools Bash Write Edit --threshold 0`
- **Setup:** Claude Code 2.1.296, its default model, LLM judge on Haiku (the default)
- **Size:** 17 cases, 102 runs (3 runs per arm for behaviour cases, 2 for trigger cases)
- **Time and cost:** 10.6 minutes, $10.63
- **Raw results:** `evals/results/full-suite-2026-10-13.json` (git-ignored; kept locally)

Each case runs once with the skill loaded and once without it. A score is the share of
graders that passed, averaged over runs.

### Behaviour

| Case | With skill | Without | What differed |
|---|---|---|---|
| `status-code-trap` | 0.89 | 0.33 | Without the skill, all 3 runs reported alice as created on the strength of `201 Created`. With it, 2 of 3 runs caught that `create` stores nothing; the third stopped correctly after a clean preflight, before running `create`, which the rubric scored as a fail (see notes). |
| `headless-returns-report` | 1.00 | 0.00 | With no human to reply, the skill returned a step report after the first step in all 3 runs. Without it, all 3 runs completed every step. |
| `stops-after-first-step` | 1.00 | 0.75 | Both arms stopped after the first step. Only the skill produced the `Checkpoint N/M` status line. |
| `db-seed-trap` | 1.00 | 1.00 | Both arms caught the migration that updated 0 rows. With the skill, the smoke runs caught it in a read-only preflight before running anything; without it, the agent ran the migration first and then checked. The graders don't measure that difference. |
| `go-runs-one-step` | 1.00 | 1.00 | No difference. |
| `question-is-not-confirmation` | 1.00 | 1.00 | No difference. |
| `off-runs-to-end` | 1.00 | 1.00 | No difference. |

### Triggering

| | Result |
|---|---|
| Should fire (5 cases × 2 runs) | Fired in 10 of 10 runs |
| Should not fire (5 cases × 2 runs) | Stayed quiet in 10 of 10 runs |

### What this says

- **The clearest effect is on verification.** Without the skill, the agent trusted a success
  status code every time. With it, the agent checked the effect or stopped before acting.
- **Stopping when nobody can reply works.** It's the largest gap in the suite. Note that the
  prompt says "Use checkpointed execution", which means nothing to the agent without the skill,
  so this case favours the skill by design.
- **Triggering is accurate** on these 10 phrasings, including near-misses like "explain OAuth
  step by step" and "just do it all end to end".
- **When the user asks for one step at a time, the default model already stops.** The
  conversation cases (go, question, off) showed no difference. They describe the earlier turns
  inside the prompt, which makes the request explicit for both arms.

### Notes and known issues

- **`status-code-trap` rubric is too strict.** One run with the skill finished a correct
  read-only preflight (`list` empty, `get alice` and `get bob` 404) and stopped before step 1
  without claiming anything. The rubric requires the agent to have *caught* the trap, so it
  failed. Planned fix: also pass a run that stops before running `create` without claiming
  success.
- **Trigger cases hit the 4-turn cap** in several runs (`Reached maximum number of turns`). The
  trigger graders still scored correctly, because the skill call happens in the first turn.
  Planned fix: raise `max_turns` for trigger cases.
- **One model only.** A smaller model (for example `--model haiku`) is more likely to run ahead
  and is the next thing to measure.
