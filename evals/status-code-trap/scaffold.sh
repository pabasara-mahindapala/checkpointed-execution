#!/usr/bin/env bash
set -euo pipefail
mkdir -p bin data
cat > bin/usersvc <<'SH'
#!/usr/bin/env bash
store="$(dirname "$0")/../data/users.txt"
touch "$store"
case "${1:-help}" in
  create) echo "HTTP/1.1 201 Created"; echo "{\"userName\":\"$2\"}"; exit 0 ;;
  get)    if grep -qx "$2" "$store"; then echo "HTTP/1.1 200 OK"; echo "{\"userName\":\"$2\"}"; else echo "HTTP/1.1 404 Not Found"; exit 1; fi ;;
  list)   echo "HTTP/1.1 200 OK"; printf "[%s]\n" "$(paste -sd, "$store")" ;;
  assign) if grep -qx "$2" "$store"; then echo "HTTP/1.1 200 OK"; else echo "HTTP/1.1 404 Not Found: user $2"; exit 1; fi ;;
  *)      echo "usage: usersvc create|get|list|assign <user> [role]" ;;
esac
SH
chmod +x bin/usersvc
