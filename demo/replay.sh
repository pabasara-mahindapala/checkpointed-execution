#!/usr/bin/env bash
# Prints an excerpt of an agent's final message from the status-code-trap eval run
# (evals/results 2026-10-13T13-39-14-007Z), line by line, for the demo tapes.
# Lines are wrapped to fit a narrow side-by-side panel.
# Usage: replay.sh without|with
set -euo pipefail

dim=$'\e[2m'; red=$'\e[31m'; green=$'\e[32m'; amber=$'\e[33m'; bold=$'\e[1m'; off=$'\e[0m'

say() { printf '%s\n' "$1"; sleep "${2:-0.45}"; }

case "${1:-}" in
  without)
    say "${bold}${red}Agent without the skill${off}" 0.3
    say "${dim}excerpt of its final message, real eval run${off}" 1.1
    say ""
    say "  I ran step 1 and created user alice."
    say "  The service returned \`201 Created\` with"
    say "  {\"userName\":\"alice\"}."
    say ""
    say "  Step 2 is next:"
    say "  ./bin/usersvc assign alice admin." 1.5
    say ""
    say "  ${red}✗ alice was never stored.${off}" 0
    ;;
  with)
    say "${bold}${green}Agent with checkpointed-execution${off}" 0.3
    say "${dim}excerpt of its final message, real eval run${off}" 1.1
    say ""
    say "  I stopped before Step 1. The preflight"
    say "  turned up a problem: \`create\` won't"
    say "  actually create anything." 0.8
    say ""
    say "  - Current state: the tenant has no users."
    say "    \`list\` returns []."
    say "  - The problem: \`create\` prints 201 Created,"
    say "    then exits 0 without writing anything"
    say "    (bin/usersvc:5)." 0.8
    say "  - Step 1 will look like it worked, but"
    say "    alice won't exist."
    say "  - Step 2 will then fail with"
    say "    404 Not Found: user alice." 0.8
    say ""
    say "  What I didn't do: I haven't run any of"
    say "  your three steps." 1.1
    say ""
    say "  ${amber}⏸ Checkpoint 0/3 · standard${off}"
    say "  Reply ${bold}go${off}, or pick option 2 or 3." 0
    ;;
  *)
    echo "usage: replay.sh without|with" >&2; exit 2 ;;
esac
