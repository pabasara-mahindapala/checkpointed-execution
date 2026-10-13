# Changelog

## 1.0.2 (2026-10-14)

- Add `documentationUrl` (README) and `supportUrl` (GitHub issues) to `plugin.json`.

## 1.0.1 (2026-10-14)

- Add a listing icon at `.claude-plugin/icon.png` for the Claude plugin directory.
- Remove the demo tape scripts; the rendered GIFs stay in `demo/`.
- Eval static-site cases use `base_url = "/"` instead of an example URL.

## 1.0.0 (2026-10-14)

First public release.

### Skill

- Stop after every step with a status line: `⏸ Checkpoint 3/7 · standard — next: …`.
- Verify each step's real effect (read-back, query, re-run) instead of trusting a success code.
- Read-only preflight (step 0) before anything changes.
- `[ME]` / `[YOU]` ownership, with exact commands and expected output for every `[YOU]` step.
- Plan and runbook written as you go, saved to files for longer work, with a resume protocol.
- Modes: `lite`, `standard` (default), `strict`, `hands-on`. Commands: `off`, `status`, and batch
  approval ("do 3 to 5, then stop").
- Defines what counts as confirmation: a question or a correction is not a go.
- When nobody can confirm (subagent, headless, or scheduled run), returns the step report instead
  of waiting or running on.
- An explicit request for checkpoints overrides auto mode and other skills that say not to pause.
- Templates in `assets/`; modes, rationalizations, and examples in `references/`.

### Evals

- 17 cases for `claude plugin eval`: 10 trigger cases and 7 behaviour cases, including a
  `201 Created` that stores nothing and a SQLite migration that updates no rows.
- Full-suite results in `evals/RESULTS.md`.

### Distribution

- `npx skills add pabasara-mahindapala/checkpointed-execution -g`
- Claude Code plugin and marketplace manifests.
