# Examples

Generic, and deliberately mundane. The model is the same whatever the domain.

## A step report that earns its checkpoint

> **Step 2 complete — stopping for review.**
>
> **Done:** created the two target containers and the service account, applied the access
> policy.
>
> **Verified:** listed the containers back — both present with the expected settings, output
> below. Wrote a probe record through the service account and read it back successfully, then
> deleted it; the store is clean.
>
> **Surprising:** the creation call returned success for a field the service silently ignored.
> The value is absent when the record is read back. Anything relying on that field must verify
> by read-back, not by response code.
>
> **Keep:** that field requires a separate registration step first — noted in the runbook as
> a prerequisite.
>
> **Not done:** did not configure the retention policy — that is step 4.
>
> ⏸ Checkpoint 2/6 · standard — next: export the source records to `artifacts/`. Reply **go**
> to continue.

## Resolving a decisive unknown early

> Step 5 depends on how records are partitioned in the target. Rather than assume, step 2
> creates one probe record and queries where it actually lands. Result: partitioning is by the
> generated identifier, not the name — so the step-5 statement can be derived per batch rather
> than hardcoded. Probe deleted; state clean.

## Reporting your own mistake

> I broke something — reporting before continuing.
>
> The call I used to add a permission is **declarative, not additive**: the list I sent
> replaced the entire existing set, and an unrelated entry not in my payload was removed. It
> still returned success. Current state and the safe alternative are below; tell me whether to
> restore.

This is the reporting standard. A checkpoint catches a wrong *direction*; it catches a wrong
*execution* only if you verify your own writes and report the result honestly.

## A `[YOU]` step with exact values

> **Step 4 — create the record [YOU]**
>
> Open `<exact URL>`, then:
>
> 1. **Name:** `example-name` — this exact value; the later step matches on it.
> 2. **Type:** Standard
> 3. **Callback:** `<exact value>`
> 4. Enable **Advanced mode**; leave everything else default.
>
> You should see a confirmation listing the new identifier — paste it back to me.
>
> ⏸ Checkpoint 4/6 · standard — waiting for the identifier.

## Catching a success code that did nothing

From a real eval run (`evals/status-code-trap`). The tool's `create` command prints
`201 Created` but never stores the user.

Without the skill:

> I ran step 1 and created user alice. The service returned `201 Created` with
> `{"userName":"alice"}`.

With the skill, after a read-only preflight:

> I stopped before Step 1. The preflight turned up a problem: `create` won't actually
> create anything. It prints `HTTP/1.1 201 Created`, then exits 0 without writing anything.
> Step 1 will look like it worked, but alice won't exist, and step 2 will then fail with
> `404 Not Found: user alice`.
