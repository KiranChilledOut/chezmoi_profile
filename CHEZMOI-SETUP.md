# Chezmoi Custom Profile Paths Setup

> How to make chezmoi copy PowerShell profiles to the correct locations

## 🎯 The Problem

Chezmoi by default copies files relative to `$HOME`, but PowerShell profiles need to be in specific locations:
- **Windows PS 5.1**: `$HOME\Documents\WindowsPowerShell\`
- **PowerShell 7+**: `$HOME\Documents\PowerShell\`
- **Starship**: `$HOME\.config\starship.toml`

## ✅ The Solution

This repo includes `run_once_setup-powershell-profiles.ps1` which automatically:
1. Creates the correct PowerShell profile directories
2. Copies profiles to both PowerShell 5.1 AND PowerShell 7+ locations
3. Sets up starship.toml in the right place

## 🚀 How It Works

### When You Run `chezmoi apply`:

1. Chezmoi copies files to its target directory (usually `$HOME`)
2. Then runs the `run_once_*` script automatically
3. The script copies profiles to the actual PowerShell profile locations
4. ✅ Your profiles are now in the right place!

### The Script Does This:

```
Source (chezmoi target):
  Documents/WindowsPowerShell/*.ps1
  dot_config/starship.toml

Destination (where PowerShell looks):
  $HOME/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
  $HOME/Documents/WindowsPowerShell/Microsoft.VSCode_profile.ps1
  $HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1  (PS7+)
  $HOME/Documents/PowerShell/Microsoft.VSCode_profile.ps1      (PS7+)
  $HOME/.config/starship.toml
```

## 📋 Manual Override (If Needed)

If you want to manually specify where files go, you can:

### Option 1: Edit the run_once script

Edit `run_once_setup-powershell-profiles.ps1` and change the destinations:

```powershell
$destinations = @{
    "WindowsPowerShell" = "C:\Your\Custom\Path\WindowsPowerShell"
    "PowerShell" = "C:\Your\Custom\Path\PowerShell"
}
```

### Option 2: Use .chezmoitemplates

Create custom templates for each file with explicit paths.

### Option 3: Use chezmoi external files

In `.chezmoi.toml.tmpl`, specify external files:

```toml
["Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"]
    type = "file"
    sourceFile = "{{ .chezmoi.sourceDir }}/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"
    targetPath = "{{ .chezmoi.homeDir }}/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
```

## 🔄 Testing

After setup, verify files are in the right place:

```powershell
# Check Windows PowerShell 5.1
Test-Path $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

# Check PowerShell 7+
Test-Path $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# Check Starship
Test-Path $HOME\.config\starship.toml

# All should return: True
```

## 🎯 Quick Setup

```powershell
# 1. Initialize chezmoi with this repo
chezmoi init https://github.com/yourname/chezmoi_profile.git

# 2. Apply (runs the setup script automatically)
chezmoi apply

# 3. Verify
Test-Path $PROFILE  # Should return True

# 4. Reload profile
. $PROFILE
```

## 🔧 Force Re-run Setup Script

If you need to re-run the setup:

```powershell
# Remove the run_once marker
chezmoi state delete-bucket --bucket=runOnce

# Apply again
chezmoi apply
```

## 📝 Notes

- The `run_once_*` script only runs once per machine
- If you update profiles, just run `chezmoi apply` - it will update the files
- Works on Windows, macOS, and Linux
- Automatically handles both PowerShell 5.1 and 7+ locations

---

**This ensures your profiles are ALWAYS in the correct location, regardless of where chezmoi's target path is!** 🎯

