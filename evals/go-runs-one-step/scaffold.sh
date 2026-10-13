#!/usr/bin/env bash
set -euo pipefail
mkdir -p config
cat > config/site.toml <<'TOML'
title = "Field Notes"
base_url = "https://example.com"
TOML
