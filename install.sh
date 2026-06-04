#!/usr/bin/env bash
# install.sh — symlink dotfiles from this repo into $HOME
#
# Layout convention:
#   <tool>/<dotfile-relative-to-HOME>
#
# Examples:
#   zsh/.zshrc                          -> ~/.zshrc
#   nvim/.config/nvim/init.lua          -> ~/.config/nvim/init.lua
#   claude/.claude/settings.json        -> ~/.claude/settings.json
#
# Only paths whose first component starts with "." are linked,
# so README.md files inside tool dirs are safely ignored.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Directories that are NOT tool directories
SKIP_DIRS=(".git")

info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }
error()   { echo "[error] $*" >&2; }

backup_if_needed() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/"
        rm -rf "$target"
        warn "Backed up $(basename "$target") -> $BACKUP_DIR/"
    fi
}

link_file() {
    local source="$1"  # absolute path in this repo
    local target="$2"  # absolute path in $HOME

    # Already correctly linked — nothing to do
    if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
        info "Already linked: $target"
        return
    fi

    backup_if_needed "$target"
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    success "Linked: $target"
    info "     -> $source"
}

is_skipped() {
    local dir="$1"
    for skip in "${SKIP_DIRS[@]}"; do
        [[ "$dir" == "$skip" ]] && return 0
    done
    return 1
}

# ── Main ─────────────────────────────────────────────────────────────────────
cd "$DOTFILES_DIR"

for tool_dir in */; do
    tool_dir="${tool_dir%/}"

    is_skipped "$tool_dir" && continue
    [[ -d "$tool_dir" ]] || continue

    # Walk every file inside the tool directory
    while IFS= read -r -d '' file; do
        # Path relative to the tool directory (e.g. ".zshrc" or ".config/nvim/init.lua")
        rel="${file#$DOTFILES_DIR/$tool_dir/}"

        # Skip anything whose first path component doesn't start with "."
        # This prevents linking READMEs or other non-dotfiles sitting in the tool dir.
        first_component="${rel%%/*}"
        [[ "$first_component" == .* ]] || continue

        link_file "$DOTFILES_DIR/$tool_dir/$rel" "$HOME/$rel"

    done < <(find "$DOTFILES_DIR/$tool_dir" -type f -print0)
done

echo ""
info "Done. All dotfiles linked to $HOME"
