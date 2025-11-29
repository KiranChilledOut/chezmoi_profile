#!/usr/bin/env pwsh
# Chezmoi run_once script to sync PowerShell profiles
# This copies profiles to wherever $PROFILE points (automatic detection)

$ErrorActionPreference = "SilentlyContinue"

Write-Host "`n=== PowerShell Profile Sync ===" -ForegroundColor Cyan

# Get the actual PowerShell profile directory from $PROFILE
$profileDir = Split-Path -Parent $PROFILE

# Detect chezmoi source
$chezmoi_target = & chezmoi target-path
$source_dir = Join-Path $chezmoi_target "Documents\WindowsPowerShell"

Write-Host "Detected profile location: $profileDir" -ForegroundColor White

# Create profile directory if it doesn't exist
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "✓ Created profile directory" -ForegroundColor Green
}

# Track if any files were changed
$filesChanged = $false

# Profile files to sync
$profileFiles = @(
    "Microsoft.PowerShell_profile.ps1",
    "Microsoft.VSCode_profile.ps1"
)

foreach ($profileFile in $profileFiles) {
    $sourcePath = Join-Path $source_dir $profileFile
    $destPath = Join-Path $profileDir $profileFile
    
    if (Test-Path $sourcePath) {
        # Check if file needs updating
        $needsUpdate = $false
        
        if (-not (Test-Path $destPath)) {
            $needsUpdate = $true
            Write-Host "  New: $profileFile" -ForegroundColor Yellow
        }
        else {
            # Compare file hashes
            $sourceHash = (Get-FileHash $sourcePath -Algorithm MD5).Hash
            $destHash = (Get-FileHash $destPath -Algorithm MD5).Hash
            
            if ($sourceHash -ne $destHash) {
                $needsUpdate = $true
                Write-Host "  Updated: $profileFile" -ForegroundColor Yellow
            }
        }
        
        if ($needsUpdate) {
            Copy-Item -Path $sourcePath -Destination $destPath -Force
            $filesChanged = $true
            Write-Host "  ✓ Synced: $profileFile" -ForegroundColor Green
        }
        else {
            Write-Host "  ✓ Up-to-date: $profileFile" -ForegroundColor Gray
        }
    }
}

# Handle starship.toml
$starship_source = Join-Path $chezmoi_target "dot_config\starship.toml"
$starship_dest = "$HOME\.config\starship.toml"

if (Test-Path $starship_source) {
    $config_dir = Split-Path $starship_dest -Parent
    if (-not (Test-Path $config_dir)) {
        New-Item -ItemType Directory -Path $config_dir -Force | Out-Null
    }
    
    # Check if starship.toml needs updating
    $needsUpdate = $false
    
    if (-not (Test-Path $starship_dest)) {
        $needsUpdate = $true
        Write-Host "  New: starship.toml" -ForegroundColor Yellow
    }
    else {
        $sourceHash = (Get-FileHash $starship_source -Algorithm MD5).Hash
        $destHash = (Get-FileHash $starship_dest -Algorithm MD5).Hash
        
        if ($sourceHash -ne $destHash) {
            $needsUpdate = $true
            Write-Host "  Updated: starship.toml" -ForegroundColor Yellow
        }
    }
    
    if ($needsUpdate) {
        Copy-Item -Path $starship_source -Destination $starship_dest -Force
        $filesChanged = $true
        Write-Host "  ✓ Synced: starship.toml" -ForegroundColor Green
    }
    else {
        Write-Host "  ✓ Up-to-date: starship.toml" -ForegroundColor Gray
    }
}

Write-Host "`n=== Sync Complete ===" -ForegroundColor Cyan

# Notify user if files changed
if ($filesChanged) {
    Write-Host "`n⚠  Profile files were updated!" -ForegroundColor Yellow
    Write-Host "   Please reload your profile to apply changes:" -ForegroundColor White
    Write-Host "   . `$PROFILE" -ForegroundColor Cyan
    Write-Host ""
}
else {
    Write-Host "All files are up-to-date. No reload needed." -ForegroundColor Green
    Write-Host ""
}
