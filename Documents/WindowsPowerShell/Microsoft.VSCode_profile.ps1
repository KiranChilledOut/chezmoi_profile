# =============================================================================
# Unified PowerShell Core Profile - Cross-Platform
# =============================================================================
# Requires: PowerShell 7+ for full cross-platform support
#
# FEATURES:
#   🎨 Starship Prompt - Beautiful git-integrated prompt with 6 color themes
#   ⌨️  PSReadLine - Predictive IntelliSense, history search, syntax highlighting  
#   🐍 Python Helpers - activate/deactivate for venv management
#   🚀 Navigation - .., ..., ...., ll, la, open
#   📂 Git Shortcuts - gs, ga, gc, gp, gl, gd
#   📝 File Operations - touch, ff (find files)
#   🔧 Utilities - ep (edit profile), reload, sysinfo, weather
#   🐳 Docker Shortcuts - dps, dimg, dstop, drm (if Docker installed)
#   📦 Optional - Terminal-Icons, z (directory jumper)
#
# =============================================================================

# -----------------------------------------------------------------------------
# Utility Functions
# -----------------------------------------------------------------------------

function Command-Exists {
    param ([string]$Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Get-OSPlatform {
    if ($IsWindows) { return "Windows" }
    elseif ($IsMacOS) { return "macOS" }
    elseif ($IsLinux) { return "Linux" }
    else { return "Unknown" }
}

# -----------------------------------------------------------------------------
# PSReadLine Configuration (Enhanced Command Line Editing)
# -----------------------------------------------------------------------------

if (Get-Module -ListAvailable -Name PSReadLine) {
    # Import only if not already loaded
    if (-not (Get-Module -Name PSReadLine)) {
        Import-Module PSReadLine -ErrorAction SilentlyContinue
    }
    
    # Get PSReadLine version to determine available features
    $psReadLineVersion = (Get-Module PSReadLine).Version
    
    # Predictive IntelliSense (requires PSReadLine 2.1.0+)
    if ($psReadLineVersion -ge [Version]"2.1.0") {
        try {
            Set-PSReadLineOption -PredictionSource HistoryAndPlugin -ErrorAction SilentlyContinue
            Set-PSReadLineOption -PredictionViewStyle ListView -ErrorAction SilentlyContinue
        }
        catch {
            # Fallback to History only
            Set-PSReadLineOption -PredictionSource History -ErrorAction SilentlyContinue
        }
    }
    
    # History search with arrow keys (works on all versions)
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward -ErrorAction SilentlyContinue
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward -ErrorAction SilentlyContinue
    
    # Ctrl+D to exit (Unix-like behavior)
    Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit -ErrorAction SilentlyContinue
    
    # Syntax highlighting colors (works on all versions)
    try {
        Set-PSReadLineOption -Colors @{
            Command   = 'Yellow'
            Parameter = 'Cyan'
            String    = 'Green'
            Operator  = 'Magenta'
            Variable  = 'White'
            Comment   = 'DarkGray'
        } -ErrorAction SilentlyContinue
    }
    catch {
        # Older versions may not support all color options
    }
    
    # Show version-specific message
    if ($psReadLineVersion -lt [Version]"2.1.0") {
        Write-Host "ℹ PSReadLine $psReadLineVersion detected. For best experience, upgrade to 2.1.0+" -ForegroundColor Yellow
        Write-Host "  Run: Install-Module PSReadLine -Force -SkipPublisherCheck" -ForegroundColor Cyan
    }
}

# -----------------------------------------------------------------------------
# Python Virtual Environment Management
# -----------------------------------------------------------------------------

function activate {
    $venvPaths = @(
        "./venv/Scripts/Activate.ps1",     # Windows
        "./.venv/Scripts/Activate.ps1",    # Windows
        "./venv/bin/Activate.ps1",         # Unix
        "./.venv/bin/Activate.ps1"         # Unix
    )
    
    foreach ($path in $venvPaths) {
        if (Test-Path $path) {
            & $path
            Write-Host "✓ Virtual environment activated" -ForegroundColor Green
            return
        }
    }
    Write-Host "✗ No virtual environment found" -ForegroundColor Red
}

function deactivate {
    if ($env:VIRTUAL_ENV) {
        $env:PATH = $env:PATH -replace [regex]::Escape("$env:VIRTUAL_ENV/bin:"), ""
        $env:PATH = $env:PATH -replace [regex]::Escape("$env:VIRTUAL_ENV\Scripts;"), ""
        Remove-Item Env:\VIRTUAL_ENV -ErrorAction SilentlyContinue
        Write-Host "✓ Virtual environment deactivated" -ForegroundColor Green
    }
}

# -----------------------------------------------------------------------------
# Productivity Aliases & Functions
# -----------------------------------------------------------------------------

# Quick navigation
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

# Enhanced directory listing
function ll { Get-ChildItem -Force | Format-Table -AutoSize }
function la { Get-ChildItem -Force }

# Git shortcuts
function gs { git status }
function ga { git add -A }
function gc { param($m) git commit -m $m }
function gp { git push }
function gl { git log --oneline --graph --decorate --all -n 10 }
function gd { git diff }

# Quick file operations
function touch {
    param($file)
    if (Test-Path $file) {
        (Get-Item $file).LastWriteTime = Get-Date
    }
    else {
        New-Item -ItemType File -Path $file | Out-Null
        Write-Host "✓ Created: $file" -ForegroundColor Green
    }
}

function ff {
    param($name)
    Get-ChildItem -Recurse -Filter "*$name*" -ErrorAction SilentlyContinue | Select-Object FullName
}

# Open current directory in file explorer
function open {
    if ($IsWindows) { explorer . }
    elseif ($IsMacOS) { open . }
    else { xdg-open . }
}

# Profile management
function ep { 
    if (Command-Exists code) { code $PROFILE }
    elseif (Command-Exists cursor) { cursor $PROFILE }
    else { notepad $PROFILE }
}
function reload { . $PROFILE; Write-Host "✓ Profile reloaded" -ForegroundColor Green }

# System info
function sysinfo {
    Write-Host "`n=== System Information ===" -ForegroundColor Cyan
    Write-Host "OS: $(Get-OSPlatform)" -ForegroundColor White
    Write-Host "PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor White
    Write-Host "User: $env:USER" -ForegroundColor White
    if ($IsWindows) {
        Write-Host "Computer: $env:COMPUTERNAME" -ForegroundColor White
        try {
            $os = Get-CimInstance Win32_OperatingSystem
            Write-Host "Memory: $([math]::Round($os.FreePhysicalMemory/1MB, 2))GB free of $([math]::Round($os.TotalVisibleMemorySize/1MB, 2))GB" -ForegroundColor White
        }
        catch {}
    }
    Write-Host ""
}

# Docker shortcuts (if docker is installed)
if (Command-Exists docker) {
    function dps { docker ps -a }
    function dimg { docker images }
    function dstop { docker stop $(docker ps -aq) }
    function drm { docker rm $(docker ps -aq) }
}

# Weather (fun utility)
function weather {
    param($city = "")
    try {
        (Invoke-WebRequest "wttr.in/$city" -UserAgent "curl").Content
    }
    catch {
        Write-Host "✗ Unable to fetch weather" -ForegroundColor Red
    }
}

# -----------------------------------------------------------------------------
# Optional Module: Terminal-Icons (if installed)
# -----------------------------------------------------------------------------

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    try {
        Import-Module Terminal-Icons -ErrorAction SilentlyContinue
        
        # Check if icons are likely to display properly
        if ($env:WT_SESSION -or $env:TERM_PROGRAM) {
            # In Windows Terminal or modern terminal
            $fontWarning = $false
        } else {
            # Might be in older terminal
            $fontWarning = $true
        }
        
        # Show one-time font reminder
        if (-not $global:TerminalIconsFontWarningShown -and $fontWarning) {
            $global:TerminalIconsFontWarningShown = $true
            Write-Host "💡 Terminal-Icons loaded! If you don't see icons:" -ForegroundColor Yellow
            Write-Host "   Set terminal font to 'CaskaydiaCove Nerd Font'" -ForegroundColor Gray
        }
    }
    catch {
        # Silently continue if it fails
    }
}

# -----------------------------------------------------------------------------
# Optional Module: z (directory jumper - if installed)
# -----------------------------------------------------------------------------

if (Get-Module -ListAvailable -Name z) {
    Import-Module z -ErrorAction SilentlyContinue
}

# -----------------------------------------------------------------------------
# Profile Initialization
# -----------------------------------------------------------------------------

$platform = Get-OSPlatform
$missingTools = @()

# Check for Starship
if (-not (Command-Exists starship)) {
    $installCmd = switch ($platform) {
        "Windows" { "winget install Starship.Starship" }
        "macOS" { "brew install starship" }
        "Linux" { "curl -sS https://starship.rs/install.sh | sh" }
    }
    $missingTools += "Starship: $installCmd"
}
else {
    # Load Starship if available
    try {
        Invoke-Expression (&starship init powershell)
    }
    catch {
        Write-Host "⚠ Failed to load Starship" -ForegroundColor Yellow
    }
}

# Display missing tools notification
if ($missingTools.Count -gt 0) {
    Write-Host "`n⚠ Missing recommended tools:" -ForegroundColor Yellow
    foreach ($tool in $missingTools) {
        Write-Host "  • $tool" -ForegroundColor Cyan
    }
    Write-Host ""
}

# Optional enhancements message (show once per session)
if (-not $global:ProfileLoadedOnce) {
    $global:ProfileLoadedOnce = $true
    
    $optionalTools = @()
    if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
        $optionalTools += "Terminal-Icons (beautiful file icons)"
    }
    if (-not (Get-Module -ListAvailable -Name z)) {
        $optionalTools += "z (directory jumper)"
    }
    
    if ($optionalTools.Count -gt 0) {
        Write-Host "💡 Optional enhancements available:" -ForegroundColor Cyan
        foreach ($tool in $optionalTools) {
            Write-Host "   $tool" -ForegroundColor Gray
        }
        Write-Host "   See README.md for installation instructions`n" -ForegroundColor Gray
    }
}
