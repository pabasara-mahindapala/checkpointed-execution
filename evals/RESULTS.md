# Eval results

Each suite is 17 cases, 82 runs: 3 runs per arm for the 7 behaviour cases and 2 per arm for the
10 trigger cases. Each case runs once with the skill loaded and once without it. A score is the
share of graders that passed, averaged over runs. The LLM judge is Haiku (the default).

Command: `claude plugin eval . -j 4 --scaffold --allow-tools Bash Write Edit --threshold 0`,
plus `--model <model>` where a model is named.

## Default model

- **Setup:** Claude Code 2.1.296, its default model
- **Skill version:** 1.0.2
- **Time and cost:** 10.6 minutes, $10.63

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

## Sonnet 5.5

- **Setup:** Claude Code 2.1.300, `--model claude-sonnet-5-5`
- **Skill version:** 1.0.3
- **Time and cost:** 5.3 minutes, $4.94

### Behaviour

| Case | With skill | Without | What differed |
|---|---|---|---|
| `status-code-trap` | 1.00 | 0.33 | Without the skill, all 3 runs reported alice as created on the strength of `201 Created`. With it, all 3 runs checked and did not claim success. |
| `headless-returns-report` | 1.00 | 0.00 | With no human to reply, the skill returned a step report after the first step in all 3 runs. Without it, all 3 runs completed every step. |
| `stops-after-first-step` | 1.00 | 0.58 | Both arms stopped after the first step. Only the skill produced the status line, and 2 of 3 runs without it stopped without showing evidence. |
| `db-seed-trap`, `go-runs-one-step`, `question-is-not-confirmation`, `off-runs-to-end` | 1.00 | 1.00 | No difference. |

### Triggering

| | Result |
|---|---|
| Should fire (5 cases × 2 runs) | Fired in 10 of 10 runs |
| Should not fire (5 cases × 2 runs) | Stayed quiet in 10 of 10 runs |

Every grader passed in every run with the skill.

## Haiku

- **Setup:** Claude Code 2.1.300, `--model haiku`
- **Skill version:** 1.0.3
- **Time and cost:** 8.3 minutes, $0.33

### Behaviour

| Case | With skill | Without | What differed |
|---|---|---|---|
| `status-code-trap` | 0.89 | 0.33 | Without the skill, all 3 runs reported alice as created on the strength of `201 Created`. With it, the agent did not claim success in any run; one run stopped after a clean preflight, before running `create`, which the rubric scored as a fail (see notes). |
| `headless-returns-report` | 0.67 | 0.00 | With no human to reply, 2 of 3 runs with the skill returned a step report after the first step; the third completed all four steps. Without it, all 3 runs completed every step. |
| `stops-after-first-step` | 1.00 | 0.67 | Both arms stopped after the first step. Only the skill produced the status line, and 1 of 3 runs without it stopped without showing evidence. |
| `db-seed-trap`, `go-runs-one-step`, `question-is-not-confirmation`, `off-runs-to-end` | 1.00 | 1.00 | No difference. |

### Triggering

| | Result |
|---|---|
| Should fire (5 cases × 2 runs) | Fired in 7 of 10 runs. Missed both runs of `walk-me-through` and 1 of 2 runs of `proactive-stateful`. |
| Should not fire (5 cases × 2 runs) | Stayed quiet in 10 of 10 runs |

## What this says

- **Without the skill, every model trusted the success code.** On all three models, all 3 runs
  without the skill reported alice as created on the strength of `201 Created`.
- **With the skill, the agent checks the effect or stops before acting.** It did not claim
  success in any `status-code-trap` run on any model.
- **Stopping when nobody can reply is the largest gap.** Note that the prompt says "Use
  checkpointed execution", which means nothing to the agent without the skill, so this case
  favours the skill by design.
- **Haiku follows the skill less reliably.** It misses softer requests like "walk me through",
  and in 1 of 3 runs with no human to confirm it still ran every step.
- **Triggering is precise on every model:** no false positives on near-misses like "explain
  OAuth step by step" or "just do it all end to end".
- **When the user asks for one step at a time, every model already stops.** The conversation
  cases (go, question, off) showed no difference. They describe the earlier turns inside the
  prompt, which makes the request explicit for both arms.

## Notes

- **`status-code-trap` rubric is too strict.** A run that finishes a correct read-only preflight
  and stops before step 1, without claiming anything, fails because the rubric requires the
  agent to have *caught* the trap.
- **Trigger cases hit the 4-turn cap** in some runs. The trigger graders still scored correctly,
  because the skill call happens in the first turn.
- **Small samples:** 2–3 runs per case. Treat single-run differences as noise.
