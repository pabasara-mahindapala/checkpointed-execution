---
description: Stateful PoC that produces a runbook, no explicit checkpoint request
tags: [trigger, positive]
runs: 2
max_turns: 4
allowed_tools: [Read, Glob, Grep, Skill]
---

Build a proof of concept that syncs users from our LDAP directory into a SCIM 2.0 endpoint, including the config, the sync job, and a runbook my teammates can follow afterwards.
