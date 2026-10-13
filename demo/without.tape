# Agent's final message (without the skill), an excerpt replayed from a real eval run
# by demo/replay.sh. Rendered at the same size as the other arm so they sit side by
# side in the README. Render from the repository root: vhs demo/without.tape

Output demo/without.gif

Require bash

Set Shell "bash"
Set FontSize 16
Set Width 620
Set Height 560
Set Padding 24
Set Theme "Catppuccin Mocha"
Set CursorBlink false

Hide
Type `export REPO="$PWD" PS1='' && clear && "$REPO/demo/replay.sh" without`
Enter
Show
Wait+Screen@30s /never stored/
Sleep 5s
