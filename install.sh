#!/usr/bin/env bash
# Neovim config installer — macOS (Ghostty) and Linux
set -e

REPO_URL="https://github.com/DobrevDeyan/nvim-config.git"
NVIM_CONFIG="$HOME/.config/nvim"

echo "==> Setting up Neovim dev environment..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    # ── macOS ──────────────────────────────────────────────────────────────
    if ! command -v brew &>/dev/null; then
        echo "==> Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "==> Installing CLI tools..."
    brew install neovim ripgrep fd node python git

    echo "==> Installing Ghostty terminal..."
    brew install --cask ghostty

    echo "==> Installing JetBrains Mono Nerd Font..."
    brew install --cask font-jetbrains-mono-nerd-font

    # Copy Ghostty config if it doesn't exist
    GHOSTTY_CFG="$HOME/.config/ghostty/config"
    if [[ ! -f "$GHOSTTY_CFG" ]]; then
        mkdir -p "$HOME/.config/ghostty"
        cat > "$GHOSTTY_CFG" <<'EOF'
font-family = JetBrainsMono Nerd Font
font-size = 14
term = xterm-256color
window-padding-x = 8
window-padding-y = 8
cursor-style = block
cursor-style-blink = false
scrollback-limit = 10000
macos-option-as-alt = true
EOF
        echo "==> Ghostty config written to $GHOSTTY_CFG"
    fi

else
    # ── Linux (Debian/Ubuntu) ──────────────────────────────────────────────
    echo "==> Installing CLI tools..."
    sudo apt update -qq
    sudo apt install -y neovim ripgrep fd-find nodejs npm python3 python3-pip git curl unzip

    # Ubuntu ships fd as fdfind
    if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
        sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
    fi

    echo "==> Installing JetBrains Mono Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    TMP=$(mktemp -d)
    curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" -o "$TMP/font.zip"
    unzip -q "$TMP/font.zip" -d "$TMP/font"
    cp "$TMP"/font/*.ttf "$FONT_DIR/"
    fc-cache -f
    rm -rf "$TMP"
fi

# ── Clone config ───────────────────────────────────────────────────────────
if [[ -d "$NVIM_CONFIG" ]]; then
    echo "==> Backing up existing config to ${NVIM_CONFIG}.bak"
    mv "$NVIM_CONFIG" "${NVIM_CONFIG}.bak"
fi

echo "==> Cloning nvim config..."
git clone "$REPO_URL" "$NVIM_CONFIG"

echo ""
echo "Done! Run 'nvim' — plugins will install automatically on first launch."
echo "After plugins finish, run :MasonUpdate inside Neovim to install LSP servers."
