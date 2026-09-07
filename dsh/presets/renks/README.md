# renks preset — patch-based source of truth

This directory holds the personal `renks` preset WITHOUT committing a copy of
dsh's third-party `standard` recipe. `../install.sh` rebuilds the recipe at
install time from whatever dsh version is installed on the machine.

| File | Role |
|---|---|
| `agent.cordis.patch` | Your personal delta on top of the stock recipe (2 swaps: instruction-hint, skill-search). Refresh this if upstream rewrites those blocks. |
| `stock-baseline.agent.cordis.yml` | Frozen upstream base the patch was made against (dsh 0.1.2-rc.1). Used only as the 3-way merge base — keep byte-identical, never hand-edit. |
| `fallback.agent.cordis.yml` | Last-known-good generated recipe. Installed automatically when a merge/patch conflict is detected, so sessions never break. Regenerate it after you refresh the patch. |
| `instruction-hint.mjs`, `skill-search.mjs`, `compaction-epoch.mjs` | Your own plugins (they only import each other, not dsh internals). |
| `preset.yml` | Name/description shown in `/preset`. |

Workflow after a dsh update: `git pull && bash dsh/install.sh`.
- Clean merge → new stock behavior + your two changes.
- Conflict → last-known-good installed + instructions to refresh the patch.
