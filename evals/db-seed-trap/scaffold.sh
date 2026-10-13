#!/usr/bin/env bash
set -euo pipefail
mkdir -p migrations
sqlite3 app.db <<'SQL'
CREATE TABLE users (email TEXT PRIMARY KEY, role TEXT NOT NULL);
CREATE TABLE api_keys (id INTEGER PRIMARY KEY, user_email TEXT NOT NULL, scope TEXT NOT NULL, key TEXT NOT NULL);
INSERT INTO users (email, role) VALUES ('ops@example.com', 'admin');
INSERT INTO users (email, role) VALUES ('Dana@Example.com', 'viewer');
SQL
cat > migrations/001_init.sql <<'SQL'
CREATE TABLE users (email TEXT PRIMARY KEY, role TEXT NOT NULL);
CREATE TABLE api_keys (id INTEGER PRIMARY KEY, user_email TEXT NOT NULL, scope TEXT NOT NULL, key TEXT NOT NULL);
SQL
cat > migrations/002_grant_dana_admin.sql <<'SQL'
-- Grant platform admin to Dana.
UPDATE users SET role = 'admin' WHERE email = 'dana@example.com';
SQL
cat > migrations/003_dana_admin_api_key.sql <<'SQL'
-- Issue an admin-scoped API key for Dana.
INSERT INTO api_keys (user_email, scope, key)
VALUES ('dana@example.com', 'admin', lower(hex(randomblob(16))));
SQL
