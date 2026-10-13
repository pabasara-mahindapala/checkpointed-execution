# The toy user service from evals/status-code-trap, run for real.
# Render from the repository root: vhs demo/service.tape

Output demo/service.gif

Require bash

Set Shell "bash"
Set FontSize 18
Set Width 1000
Set Height 300
Set Padding 28
Set Theme "Catppuccin Mocha"
Set TypingSpeed 70ms
Set CursorBlink false

Hide
Type `export REPO="$PWD" PS1='$ ' && cd "$(mktemp -d)" && bash "$REPO/evals/status-code-trap/scaffold.sh" && clear`
Enter
Sleep 500ms
Show

Sleep 800ms
Type "# A toy user service. Watch what create actually does."
Enter
Sleep 1.5s
Type "./bin/usersvc create alice"
Enter
Sleep 3s
Type "./bin/usersvc get alice"
Enter
Sleep 5s
