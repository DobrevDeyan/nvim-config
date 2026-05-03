# nvim-config

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) — built for JavaScript, React, Vue, PHP, and Python development on macOS M1, with Claude Code AI integration.

---

## Table of Contents

- [Philosophy](#philosophy)
- [Requirements](#requirements)
- [Install](#install)
- [Plugins](#plugins)
- [LSP Servers](#lsp-servers)
- [Key Bindings](#key-bindings)
- [Claude Code Integration](#claude-code-integration)
- [Understanding Modal Editing](#understanding-modal-editing)
- [Architecture Overview](#architecture-overview)

---

## Philosophy

This config follows the Unix philosophy: Neovim handles text editing with surgical precision, while external tools handle everything else (language intelligence, linting, formatting, AI assistance). The result is a near-instant, keyboard-driven environment that scales across languages without becoming a monolithic IDE.

The three pillars:

- **LSP** — language servers provide Go-to-Definition, references, diagnostics, and completion
- **Treesitter** — accurate syntax highlighting based on real parse trees, not regex
- **Telescope** — unified fuzzy search across files, grep, buffers, symbols, and git history

---

## Requirements

| Tool | Purpose | macOS | Windows |
|---|---|---|---|
| Neovim >= 0.10 | Editor | `brew install neovim` | `winget install Neovim.Neovim` |
| ripgrep | Telescope live grep | `brew install ripgrep` | `winget install BurntSushi.ripgrep.MSVC` |
| fd | Telescope file search | `brew install fd` | `winget install sharkdp.fd` |
| Node.js | JS/TS LSP, formatters | `brew install node` | `winget install OpenJS.NodeJS.LTS` |
| Python 3 | Python LSP | `brew install python` | `winget install Python.Python.3` |
| Git | Plugin manager, fugitive | built-in | `winget install Git.Git` |
| JetBrains Mono Nerd Font | Icons in UI | `brew install --cask font-jetbrains-mono-nerd-font` | see installer |

**Terminal:**
- macOS: [Ghostty](https://ghostty.org) — GPU-accelerated, Metal-native, best choice for M1
- Windows: Windows Terminal (built into Win 11) — set font to `JetBrainsMono Nerd Font`

---

## Install

### macOS (one command)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/DobrevDeyan/nvim-config/main/install.sh)
```

Installs: Neovim, Ghostty, ripgrep, fd, Node, Python, Nerd Font — then clones this config.

Or clone manually:
```bash
git clone https://github.com/DobrevDeyan/nvim-config.git ~/.config/nvim
```

### Windows 11 (one command)

```powershell
# Allow scripts (run once):
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install everything:
Invoke-WebRequest https://raw.githubusercontent.com/DobrevDeyan/nvim-config/main/install.ps1 -OutFile install.ps1; .\install.ps1
```

Installs: Neovim, ripgrep, fd, Node, Python, Git, Nerd Font via winget — then clones this config.

Or clone manually:
```powershell
git clone https://github.com/DobrevDeyan/nvim-config.git $env:LOCALAPPDATA\nvim
```

### After installing (all platforms)

1. Open `nvim` — lazy.nvim auto-downloads all plugins on first launch (~1 min)
2. Run `:MasonUpdate` inside Neovim to install LSP servers
3. Restart `nvim`

---

## Plugins

| Plugin | Purpose |
|---|---|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme with transparent background |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Fast status line with git and LSP info |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, buffers |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Accurate syntax highlighting via parse trees |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion (LSP + buffer + path sources) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Install and manage LSP servers in-editor |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Bookmark and jump between key files instantly |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating/split terminals + dedicated Claude terminal |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands from inside Neovim |
| [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) | Inline color preview for CSS/hex values |
| [vim-oscyank](https://github.com/ojroques/vim-oscyank) | Clipboard sync over SSH tunnels |

---

## LSP Servers

Managed by Mason — auto-installed on `:MasonUpdate`.

| Language | Server | Notes |
|---|---|---|
| JavaScript / TypeScript / React | `ts_ls` | Full JS/TS/JSX/TSX support |
| Vue | `ts_ls` | Use with Volar for SFCs |
| PHP / Laravel | `intelephense` | PSR-compliant intelligence |
| Python | `pyright` | Type checking, auto-imports |
| CSS / SCSS | `cssls` | Validation and completion |
| JavaScript linting | `eslint` | Real-time lint feedback |
| Lua (Neovim config) | `lua_ls` | Neovim API awareness |

Format-on-save is enabled automatically for all supported file types (excluding PHP and C/C++ where it is opt-in via `<F3>`).

---

## Key Bindings

`<leader>` is `Space`.

### Navigation

| Key | Action |
|---|---|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep across project |
| `<leader>fb` | Open buffer list |
| `<leader>fh` | Search help tags |
| `<leader>a` | Harpoon: mark current file |
| `<C-e>` | Harpoon: open file menu |
| `<C-p>` / `<C-n>` | Harpoon: jump prev/next |
| `<leader>fl` | Harpoon list in Telescope |
| `<leader>cd` | Open file explorer (netrw) |

### Windows & Splits

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between splits |
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<Esc>` | Clear search highlight |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `go` | Go to type definition |
| `K` | Hover documentation |
| `gs` | Signature help |
| `gl` | Show diagnostics float |
| `<F2>` | Rename symbol |
| `<F3>` | Format file/selection |
| `<F4>` | Code actions |

### Terminal

| Key | Action |
|---|---|
| `<C-\>` | Toggle floating terminal |
| `<leader>tc` | Toggle Claude Code terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal split terminal |
| `<leader>tv` | Vertical split terminal |
| `<Esc><Esc>` | Exit terminal mode |

---

## Claude Code Integration

This config ships with a dedicated Claude Code terminal binding. Press `<leader>tc` to open a floating terminal running the `claude` CLI directly inside Neovim.

**Setup:**
```bash
npm install -g @anthropic-ai/claude-code
claude  # authenticate on first run
```

**Workflow:**
1. Open Claude with `<leader>tc`
2. Ask it to refactor, add tests, explain code, etc.
3. Files modified by Claude are hot-reloaded automatically in your buffers
4. Review diffs with `:Gdiff` (vim-fugitive) before committing

**Tip:** Add a `CLAUDE.md` file to your project root to give Claude persistent instructions — coding standards, framework conventions, forbidden patterns. It reads this file automatically on every session.

---

## Understanding Modal Editing

Neovim operates in distinct modes. The keyboard is not just for typing — in Normal mode it becomes a command console.

### Modes

| Mode | Purpose | Enter with |
|---|---|---|
| Normal | Navigation and manipulation (default) | `<Esc>` |
| Insert | Character insertion | `i`, `a`, `o` |
| Visual | Selection | `v`, `V`, `<C-v>` |
| Command | Save, quit, search-replace | `:` |
| Terminal | Shell session in a buffer | `<C-\>` |

### The Grammar of Commands

Neovim commands follow a grammar: **verb + modifier + noun**.

```
d  i  w   → delete inside word
c  a  "   → change around quotes
y  i  p   → yank (copy) inside paragraph
>  i  {   → indent inside braces
```

A small set of primitives (`d`, `c`, `y`, `v`, `i`, `a`, `f`, `t`, `w`, `b`, `e`...) compose into hundreds of precise operations — no mouse, no highlighting, no arrow keys.

### Survival Cheatsheet

| Key | Action |
|---|---|
| `h j k l` | Move left / down / up / right |
| `w / b` | Next / previous word |
| `0 / $` | Start / end of line |
| `gg / G` | Top / bottom of file |
| `i / a` | Insert before / after cursor |
| `o / O` | New line below / above |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `u` | Undo |
| `<C-r>` | Redo |
| `/pattern` | Search forward |
| `n / N` | Next / previous match |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |

---

## Architecture Overview

```
~/.config/nvim/
├── init.lua                  # Entry point — loads config modules
├── lua/
│   ├── config/
│   │   ├── options.lua       # Editor settings (tabs, numbers, clipboard...)
│   │   ├── keymaps.lua       # Custom key bindings
│   │   ├── lazy.lua          # Plugin manager bootstrap
│   │   └── lsp.lua           # LSP configs for all languages + diagnostics UI
│   └── plugins/
│       ├── init.lua          # Colorscheme + lualine
│       ├── cmp.lua           # Autocompletion
│       ├── telescope.lua     # Fuzzy finder
│       ├── treesitter.lua    # Syntax highlighting
│       ├── mason.lua         # LSP server management
│       ├── harpoon.lua       # File bookmarks
│       ├── toggleterm.lua    # Terminal + Claude Code
│       └── oneliners.lua     # git, colors, clipboard plugins
├── lazy-lock.json            # Pinned plugin versions (reproducible installs)
├── install.sh                # macOS + Linux installer
└── install.ps1               # Windows 11 installer
```

**Config path by platform:**

| Platform | Config location |
|---|---|
| macOS / Linux | `~/.config/nvim/` |
| Windows | `%LOCALAPPDATA%\nvim\` |
