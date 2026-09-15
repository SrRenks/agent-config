#!/usr/bin/env bash
# setup.sh - Install agent-config for every supported tool on this machine.
# Run once per machine (idempotent). Derives paths from its own location,
# so the repo can be cloned anywhere.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${SRC}/backups/$(date +%Y%m%d-%H%M%S)"

backup() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/"
        echo "  backed up: $target -> $BACKUP_DIR/"
    fi
}

symlink() {
    local src="$1"
    local dst="$2"
    backup "$dst"
    rm -rf "$dst"
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "  linked: $dst -> $src"
}

echo "=== agent-config setup (SRC: ${SRC}) ==="

# ── Claude Code ──────────────────────────────────────────────────────────────
symlink "$SRC/agents/claude-code/CLAUDE.md"       "$HOME/.claude/CLAUDE.md"
symlink "$SRC/agents/claude-code/CLAUDE.local.md" "$HOME/.claude/CLAUDE.local.md"
symlink "$SRC/agents/claude-code/settings.json"   "$HOME/.claude/settings.json"
symlink "$SRC/skills"                             "$HOME/.claude/skills"
symlink "$SRC/agents/claude-code/hooks"           "$HOME/.claude/hooks"
symlink "$SRC/agents/claude-code/rules"           "$HOME/.claude/rules"
symlink "$SRC/agents/claude-code/commands"        "$HOME/.claude/commands"
symlink "$SRC/agents/claude-code/claudeignore"    "$HOME/.claudeignore"

# ── Codex ────────────────────────────────────────────────────────────────────
symlink "$SRC/AGENTS.md" "$HOME/.codex/AGENTS.md"

# ── Gemini CLI ───────────────────────────────────────────────────────────────
symlink "$SRC/agents/gemini/GEMINI.md" "$HOME/.gemini/GEMINI.md"

# ── Cursor (reuses the shared rules: combined frontmatter serves both) ───────
symlink "$SRC/agents/claude-code/rules" "$HOME/.cursor/rules"

# ── Generic fallback (some tools read ~/.agents/AGENTS.md) ───────────────────
symlink "$SRC/AGENTS.md" "$HOME/.agents/AGENTS.md"

# ── Git identity (directory-scoped; see core/docs/git-workflow.md) ─────────────
GC="$HOME/.gitconfig"
IDENT="$HOME/.config/git/identity"
if [ ! -f "$IDENT" ]; then
    mkdir -p "$(dirname "$IDENT")"
    NAME=$(git config --global user.name 2>/dev/null || true)
    EMAIL=$(git config --global user.email 2>/dev/null || true)
    printf '[user]\n\tname = %s\n\temail = %s\n' "${NAME:-YOUR NAME}" "${EMAIL:-you@example.com}" > "$IDENT"
    chmod 600 "$IDENT"
    echo "  created: $IDENT (personal data - never tracked in a repo)"
fi
if grep -q 'config/git/identity' "$GC" 2>/dev/null; then
    echo "  skip: ~/.gitconfig already includes $IDENT"
else
    mkdir -p "$(dirname "$GC")"
    printf '\n[includeIf "gitdir:~/Projects/**"]\n\tpath = %s\n[includeIf "gitdir:~/.config/**"]\n\tpath = %s\n' "$IDENT" "$IDENT" >> "$GC"
    echo "  wired: ~/.gitconfig includes $IDENT for ~/Projects/** and ~/.config/**"
fi

# ── ai-init / ai-context commands ────────────────────────────────────────────
mkdir -p "$HOME/.local/bin"
ln -sfn "$SRC/ai-init" "$HOME/.local/bin/ai-init"
ln -sfn "$SRC/ai-context" "$HOME/.local/bin/ai-context"
echo "  linked: ~/.local/bin/ai-init -> $SRC/ai-init"
echo "  linked: ~/.local/bin/ai-context -> $SRC/ai-context"

echo ""
echo "Done. Installed:"
echo "  Claude Code : ~/.claude/ (CLAUDE.md, skills, hooks, rules, commands, settings.json)"
echo "  Codex       : ~/.codex/AGENTS.md"
echo "  Gemini CLI  : ~/.gemini/GEMINI.md"
echo "  Cursor      : ~/.cursor/rules"
echo "  Generic     : ~/.agents/AGENTS.md"
echo "  Commands    : ~/.local/bin/ai-init, ai-context"
echo "  Git identity : ~/.config/git/identity (conditional include from ~/.gitconfig)"
echo ""
echo "dsh (DeepSeek Harness) is installed separately:"
echo "  bash \"$SRC/agents/dsh/install.sh\""
