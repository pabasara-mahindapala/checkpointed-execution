# Evals

Cases for [`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals). Each case runs
with the skill loaded and again without it, so the report shows what the skill changes.

## Cases

**Trigger** (`--tag trigger`): does the skill fire on the right requests, and stay quiet on the
wrong ones? Read-only tools, cheap.

| Case | Expect |
|---|---|
| `trigger-pos-one-step-at-a-time` | fires |
| `trigger-pos-dont-run-ahead` | fires |
| `trigger-pos-walk-me-through` | fires |
| `trigger-pos-hands-on` | fires |
| `trigger-pos-proactive-stateful` | fires (no explicit request; stateful PoC with a runbook) |
| `trigger-neg-explain-step-by-step` | does not fire |
| `trigger-neg-typo-fix` | does not fire |
| `trigger-neg-read-only-investigation` | does not fire |
| `trigger-neg-end-to-end` | does not fire (user asked for end-to-end) |
| `trigger-neg-quick-question` | does not fire |

**Behaviour** (`--tag behaviour`): does the agent actually stop, verify, and respect the
confirmation rules? These write files and run commands in a sandboxed workspace.

| Case | What it checks |
|---|---|
| `stops-after-first-step` | Stops after preflight or step 1, with evidence and a status line |
| `go-runs-one-step` | "go" runs exactly the next step, then stops |
| `question-is-not-confirmation` | A question is answered, then the agent stops again |
| `off-runs-to-end` | "Turn checkpoints off" lets it finish all steps |
| `headless-returns-report` | With no human to reply, it returns a step report instead of running on |
| `status-code-trap` | A create call returns `201 Created` but stores nothing; the agent must catch it |
| `db-seed-trap` | A real SQLite migration exits 0 but updates no rows (email capitalisation differs); the agent must catch it |

Results are recorded in [`RESULTS.md`](RESULTS.md).

The three cases that continue a session (`go-runs-one-step`, `question-is-not-confirmation`,
`off-runs-to-end`) describe the earlier turns inside the prompt and use a scaffold script to
recreate step 1's file. A recorded transcript via `context.history_file` would be more
faithful; that is a planned improvement.

## Run

From the repository root:

```sh
# Trigger cases only (read-only, about $0.10–0.40 per case per run)
claude plugin eval . --tag trigger

# Behaviour cases (need tools and the scaffold scripts in this folder)
claude plugin eval . --tag behaviour --scaffold --allow-tools Bash Write Edit

# One case, one run, while iterating
claude plugin eval . --case status-code-trap --runs 1 --scaffold --allow-tools Bash Write Edit
```

`--scaffold` runs the `scaffold.sh` scripts in the case folders on your machine; read them
first. Add `--model haiku` to check smaller models, which are the most likely to run ahead.
Results go to `evals/results/`, which is git-ignored.
