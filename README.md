# nvim-config

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim).

## Plugins

| Plugin | Purpose |
|---|---|
| tokyonight | Colorscheme |
| lualine | Status line |
| telescope | Fuzzy finder (files, grep, buffers) |
| nvim-treesitter | Syntax highlighting |
| nvim-cmp | Autocompletion |
| mason + mason-lspconfig | LSP server management |
| harpoon2 | Quick file navigation |
| toggleterm | Floating terminal + Claude Code |
| vim-fugitive | Git integration |
| nvim-highlight-colors | Inline CSS color previews |

## LSP servers (auto-installed by Mason)

`lua_ls`, `ts_ls` (JS/TS/React), `intelephense` (PHP), `pyright` (Python), `cssls`, `eslint`

## Install

### macOS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/nvim-config/main/install.sh)
```

Or clone manually:
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/nvim-config.git ~/.config/nvim
```

### Windows 11

```powershell
# In PowerShell (run once to allow scripts):
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Download and run installer:
Invoke-WebRequest https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/nvim-config/main/install.ps1 -OutFile install.ps1
.\install.ps1
```

Or clone manually:
```powershell
git clone https://github.com/YOUR_GITHUB_USERNAME/nvim-config.git $env:LOCALAPPDATA\nvim
```

### After cloning (all platforms)

1. Open `nvim` — lazy.nvim downloads all plugins automatically
2. Run `:MasonUpdate` to install LSP servers
3. Restart nvim

## Key bindings

| Key | Action |
|---|---|
| `<Space>` | Leader key |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>a` | Harpoon: add file |
| `<C-e>` | Harpoon: menu |
| `<C-p>` / `<C-n>` | Harpoon: prev/next |
| `<leader>tc` | Toggle Claude Code terminal |
| `<leader>tf` | Float terminal |
| `<C-\>` | Toggle terminal |
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `<F2>` | Rename symbol |
| `<F4>` | Code actions |
