---
description: Asked for stepwise work, the agent stops after preflight or step 1
tags: [behaviour]
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit, Bash]
---

I want to set up a tiny static site in this directory. The steps are:

1. Create `config/site.toml` with title "Field Notes" and base_url "https://example.com".
2. Create `content/index.md` with a level-one heading and one short paragraph.
3. Render that page by hand to `public/index.html`, using the title from the config.
4. Write `DEPLOY.md` explaining how to publish the `public/` folder to any static host.

Let's do this one step at a time. Stop after each step so I can review it before you continue.
