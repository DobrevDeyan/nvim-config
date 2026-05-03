# Neovim config installer — Windows 11
# Run once to allow scripts: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Then run: .\install.ps1

param(
    [string]$RepoUrl = "https://github.com/DobrevDeyan/nvim-config.git"
)

$ErrorActionPreference = "Stop"
$NvimConfig = "$env:LOCALAPPDATA\nvim"

Write-Host "==> Setting up Neovim dev environment on Windows..." -ForegroundColor Cyan

# ── winget ────────────────────────────────────────────────────────────────
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget not found. Install 'App Installer' from the Microsoft Store."
    exit 1
}

$packages = @(
    @{ id = "Neovim.Neovim" },
    @{ id = "Git.Git" },
    @{ id = "OpenJS.NodeJS.LTS" },
    @{ id = "Python.Python.3" },
    @{ id = "BurntSushi.ripgrep.MSVC" },
    @{ id = "sharkdp.fd" }
)

foreach ($pkg in $packages) {
    Write-Host "==> Installing $($pkg.id)..."
    winget install --id $pkg.id -e --silent --accept-source-agreements --accept-package-agreements
}

# ── Nerd Font ─────────────────────────────────────────────────────────────
Write-Host "==> Installing JetBrains Mono Nerd Font..."
$fontZip  = "$env:TEMP\JetBrainsMono.zip"
$fontDir  = "$env:TEMP\JetBrainsMonoNF"
$fontUrl  = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

Invoke-WebRequest -Uri $fontUrl -OutFile $fontZip -UseBasicParsing
Expand-Archive -Path $fontZip -DestinationPath $fontDir -Force

$shellFonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
Get-ChildItem "$fontDir\*.ttf" | ForEach-Object {
    if (-not (Test-Path "$env:WINDIR\Fonts\$($_.Name)")) {
        $shellFonts.CopyHere($_.FullName, 0x10)
    }
}
Write-Host "   Font installed. Set 'JetBrainsMono Nerd Font' in Windows Terminal > Settings > Appearance."

# ── Clone config ──────────────────────────────────────────────────────────
if (Test-Path $NvimConfig) {
    $backup = "$NvimConfig.bak"
    Write-Host "==> Backing up existing config to $backup"
    Move-Item $NvimConfig $backup -Force
}

Write-Host "==> Cloning nvim config..."
git clone $RepoUrl $NvimConfig

# ── Windows Terminal hint ─────────────────────────────────────────────────
Write-Host ""
Write-Host "==> Recommended: install Windows Terminal from the Microsoft Store if not already installed."
Write-Host "    In Windows Terminal Settings > Profiles > Defaults > Appearance:"
Write-Host "    - Font face: JetBrainsMono Nerd Font"
Write-Host "    - Font size: 14"
Write-Host ""
Write-Host "Done! Open a new terminal and run 'nvim'." -ForegroundColor Green
Write-Host "Plugins install automatically on first launch." -ForegroundColor Green
Write-Host "Afterwards run :MasonUpdate inside Neovim to install LSP servers." -ForegroundColor Yellow
