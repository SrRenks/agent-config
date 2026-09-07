#!/usr/bin/env bash
# dsh/install.sh — install the personal dsh layer on this machine.
#
# One command after `git clone`:
#     bash ~/.config/agent-config/dsh/install.sh
#
# Idempotent: safe to re-run after every `git pull` or dsh update. It rebuilds
# the `renks` preset from the dsh version ACTUALLY INSTALLED here (stock
# `standard` preset + your personal patch, 3-way merged), then falls back to
# the last-known-good generated preset if upstream changed your touched blocks.
# It never leaves a broken preset installed.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # .../agent-config/dsh
REPO="$(cd "${SRC}/.." && pwd)"                      # repo root (clone location)
DSH_H="${DSH_HOME:-${HOME}/.dsh}"
PRESET_DIR="${SRC}/presets/renks"
STOCK="${DSH_H}/profiles/node_modules/@deepseek-ai/dsh-agent-presets/presets/standard/agent.cordis.yml"

echo "=== dsh personal layer install ==="
echo "  repo     : ${REPO}"
echo "  dsh home : ${DSH_H}"

# ── 1) Rebuild the preset recipe for THIS dsh version ────────────────────────
BASE="${PRESET_DIR}/stock-baseline.agent.cordis.yml"
PATCH="${PRESET_DIR}/agent.cordis.patch"
FALLBACK="${PRESET_DIR}/fallback.agent.cordis.yml"
WORK="$(mktemp -d)"; trap 'rm -rf "${WORK}"' EXIT
RESULT="${WORK}/agent.cordis.yml"
STATUS="merged"

if [ ! -f "${STOCK}" ]; then
  echo "  [error] stock preset not found: ${STOCK}"
  echo "          Install dsh first (the profile bundles ship it), then re-run."
  exit 1
fi

# apply your patch onto the frozen baseline
cp "${BASE}" "${RESULT}"
if ! (cd "${WORK}" && git apply "${PATCH}" 2>/dev/null); then
  STATUS="fallback (patch no longer applies to the baseline)"
fi

# 3-way merge: baseline + your patch  vs  the installed stock recipe
if [ "${STATUS}" = "merged" ]; then
  git merge-file "${RESULT}" "${BASE}" "${STOCK}" >/dev/null 2>&1 || true  # nonzero = conflicts
  if grep -q '^<<<<<<<' "${RESULT}"; then
    STATUS="fallback (upstream changed your touched blocks)"
  fi
fi

# validation gate: your two plugin rows must survive the merge
if [ "${STATUS}" = "merged" ] && { ! grep -q 'id: instruction-hint' "${RESULT}" || ! grep -q 'id: skill-search' "${RESULT}"; }; then
  STATUS="fallback (merged recipe lost your plugin rows)"
fi

# YAML sanity when dsh's yaml parser is available (non-fatal gate)
if [ "${STATUS}" = "merged" ] && [ -d "${DSH_H}/profiles/node_modules/yaml" ]; then
  if ! (cd "${DSH_H}/profiles" && node -e "require('yaml').parse(require('fs').readFileSync(process.argv[1],'utf8'))" "${RESULT}" >/dev/null 2>&1); then
    STATUS="fallback (merged recipe failed YAML parse)"
  fi
fi

if [ "${STATUS}" = "merged" ]; then
  echo "  [ok] recipe rebuilt for the installed dsh version (clean 3-way merge)"
else
  cp "${FALLBACK}" "${RESULT}"
  echo "  [warn] ${STATUS} — installing last-known-good preset instead."
  echo "         Everything keeps working as before. To refresh the patch later:"
  echo "         diff ${STOCK} against ${BASE} and update ${PATCH}."
fi

# ── 2) Install the renks preset where dsh discovers it ───────────────────────
mkdir -p "${DSH_H}/.agent-presets/renks"
cp -f "${PRESET_DIR}/preset.yml" "${DSH_H}/.agent-presets/renks/preset.yml"
cp -f "${RESULT}" "${DSH_H}/.agent-presets/renks/agent.cordis.yml"
for f in "${PRESET_DIR}"/*.mjs; do
  [ -e "$f" ] && cp -f "$f" "${DSH_H}/.agent-presets/renks/"
done
echo "  [ok] preset 'renks' installed at ${DSH_H}/.agent-presets/renks"

# ── 3) User-global rules + skills (symlinks: `git pull` updates propagate) ───
ln -sfn "${REPO}/AGENTS.md" "${DSH_H}/AGENTS.md"
ln -sfn "${SRC}/skills" "${DSH_H}/skills"
echo "  [ok] symlinks: ${DSH_H}/AGENTS.md -> repo AGENTS.md ; ${DSH_H}/skills -> repo dsh/skills"

# ── 4) Make renks the default preset for new sessions ────────────────────────
if grep -q '^agent-presets:' "${DSH_H}/settings.yaml" 2>/dev/null; then
  echo "  [skip] settings.yaml already has an agent-presets section"
else
  printf '\nagent-presets:\n  default: renks\n' >> "${DSH_H}/settings.yaml"
  echo "  [ok] settings.yaml: agent-presets.default = renks"
fi

echo ""
echo "Done. Open a NEW dsh session — the default preset is 'renks'."
echo "Use /preset to switch back to stock 'standard' at any time."
