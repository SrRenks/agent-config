#!/usr/bin/env bash
# setup.sh - Install agent-config globally
# Run once. Creates symlinks from ~/.config/agent-config/ to agent paths.
set -euo pipefail

SRC="$HOME/.config/agent-config"
BACKUP_DIR="$HOME/.config/agent-config/backups/$(date +%Y%m%d-%H%M%S)"

backup() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/"
        echo "  backed up: $target → $BACKUP_DIR/"
    fi
}

symlink() {
    local src="$1"
    local dst="$2"
    backup "$dst"
    rm -rf "$dst"
    ln -sf "$src" "$dst"
    echo "  linked: $dst → $src"
}

echo "=== agent-config setup ==="

# Claude Code - all 5 layers of the hierarchy
symlink "$SRC/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
symlink "$SRC/CLAUDE.local.md" "$HOME/.claude/CLAUDE.local.md"
symlink "$SRC/settings.json" "$HOME/.claude/settings.json"
symlink "$SRC/skills" "$HOME/.claude/skills"
symlink "$SRC/hooks" "$HOME/.claude/hooks"
symlink "$SRC/rules" "$HOME/.claude/rules"
symlink "$SRC/commands" "$HOME/.claude/commands"
symlink "$SRC/claudeignore" "$HOME/.claudeignore"

# Codex
symlink "$SRC/AGENTS.md" "$HOME/.codex/AGENTS.md"

# Gemini
symlink "$SRC/GEMINI.md" "$HOME/.gemini/GEMINI.md"

# Generic fallback (some tools read ~/.agents/AGENTS.md)
symlink "$SRC/AGENTS.md" "$HOME/.agents/AGENTS.md"

# ai-init / ai-context commands (symlinks so they stay in sync)
mkdir -p "$HOME/.local/bin"
ln -sfn "$SRC/ai-init" "$HOME/.local/bin/ai-init"
ln -sfn "$SRC/ai-context" "$HOME/.local/bin/ai-context"
echo "  linked: ~/.local/bin/ai-init -> $SRC/ai-init"
echo "  linked: ~/.local/bin/ai-context -> $SRC/ai-context"

echo ""
echo "Done. Layers installed:"
echo "  Layer 1: ~/.claude/CLAUDE.md       (user-level rules)"
echo "  Layer 2: ~/.claude/CLAUDE.local.md (personal overrides)"
echo "  Layer 3: ~/.claude/rules/          (scoped rules)"
echo "  Layer 4: ~/.claude/settings.json   (hooks + permissions)"
echo "  Layer 5: ~/.claude/commands/       (slash commands)"
echo ""
echo "Also: ~/.codex/AGENTS.md, ~/.gemini/GEMINI.md, ~/.agents/AGENTS.md"
echo ""
echo "Verify: ls -la ~/.claude/"
echo "New project: cd /path/to/project && ai-init"
echo "  (memory skeleton + maturity detection; no template README)"
echo "Context + README on demand: cd /path/to/project && ai-context"
echo "  (detects stack/db/deps/conventions; writes .ai/context/ + README.md)"
