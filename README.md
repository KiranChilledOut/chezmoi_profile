# Cross-Platform PowerShell Profile

> Unified PowerShell profiles for **Windows**, **macOS**, and **Linux** with automatic Starship prompt and tool configuration.

## ⚡ Quick Fix for Chocolatey Issues

If you're seeing **"Access to path denied"** errors with Chocolatey:

```powershell
# 1. Open PowerShell as Administrator (Right-click → Run as Administrator)
# 2. Run the repair function:
Fix-Chocolatey

# If that doesn't work, use winget instead:
winget install Starship.Starship
```

---

## What This Does

- ✅ **Cross-platform PowerShell profile** - Works on Windows, macOS, and Linux
- ✅ **Starship prompt** - Beautiful, informative git-integrated prompt with multiple color themes
- ✅ **PSReadLine enhancements** - Predictive IntelliSense, history search, syntax highlighting
- ✅ **Python virtual environment helpers** - Easy `activate`/`deactivate` commands
- ✅ **Productivity aliases** - Git shortcuts, quick navigation, file operations
- ✅ **Optional modules** - Terminal-Icons, z (directory jumper)
- ✅ **Lightweight IDE profile** - Fast-loading profile for VS Code/Cursor
- ✅ **Works with chezmoi** - Sync configurations across all your machines

## 📋 Complete Feature List

### 🎨 **Starship Prompt**
- Git integration (branch, status, ahead/behind)
- Command execution time
- Current directory with truncation
- Username and hostname display
- Memory usage indicator
- OS icon display
- Admin/elevated session indicator (⚡)
- **5 color palettes**: flexoki_dark, catppuccin_mocha, tokyo_night, gruvbox_dark, nord, dracula

### ⌨️ **PSReadLine Features**
- **Predictive IntelliSense** - Shows suggestions from your command history
- **ListView** - Multiple suggestions in a list
- **History search** - Use ↑/↓ arrows to search through history
- **Ctrl+D to exit** - Unix-like behavior
- **Syntax highlighting** - Color-coded commands, parameters, strings

### 🐍 **Python Development**
- `activate` - Auto-detects and activates venv/virtualenv (cross-platform paths)
- `deactivate` - Deactivates current virtual environment

### 🚀 **Navigation Shortcuts**
- `..` - Go up one directory
- `...` - Go up two directories
- `....` - Go up three directories
- `ll` - Enhanced directory listing
- `la` - List all files including hidden
- `open` - Open current directory in file explorer

### 📂 **Git Shortcuts**
- `gs` - `git status`
- `ga` - `git add -A`
- `gc "message"` - `git commit -m "message"`
- `gp` - `git push`
- `gl` - `git log` (pretty graph format, last 10 commits)
- `gd` - `git diff`

### 📝 **File Operations**
- `touch filename` - Create file or update timestamp
- `ff pattern` - Find files recursively by name pattern

### 🔧 **Profile Management**
- `ep` - Edit profile in your preferred editor (code/cursor/notepad)
- `reload` - Reload profile without restarting PowerShell

### 💻 **System Info**
- `sysinfo` - Display OS, PowerShell version, memory usage
- `Get-OSPlatform` - Returns current OS (Windows/macOS/Linux)

### 🐳 **Docker Shortcuts** (if Docker installed)
- `dps` - `docker ps -a`
- `dimg` - `docker images`
- `dstop` - Stop all containers
- `drm` - Remove all containers

### 🎉 **Fun Utilities**
- `weather [city]` - Display weather in terminal

### 📦 **Optional Enhanced Modules**
Install these for additional features:
- **Terminal-Icons** - Beautiful file/folder icons in listings
  ```powershell
  Install-Module -Name Terminal-Icons -Scope CurrentUser
  ```
- **z** - Jump to frequently used directories
  ```powershell
  Install-Module -Name z -AllowClobber -Scope CurrentUser
  ```

---

## 🚀 Setup for New Machine

### Prerequisites

**All Platforms:**
- **PowerShell 7+** ([Download here](https://github.com/PowerShell/PowerShell/releases)) - Required for cross-platform support

### Step 1: Install chezmoi

**Windows (PowerShell as Admin):**
```powershell
winget install twpayne.chezmoi
# or
choco install chezmoi
```

**macOS:**
```bash
brew install chezmoi
```

**Linux:**
```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Step 2: Initialize with Your Repository

Replace `yourusername/chezmoi_profile` with your actual repository:

```bash
chezmoi init https://github.com/yourusername/chezmoi_profile.git
```

Or if using SSH:

```bash
chezmoi init git@github.com:yourusername/chezmoi_profile.git
```

### Step 3: Review Changes (Optional)

See what will be installed:

```bash
chezmoi diff
```

### Step 4: Apply Configuration

```bash
chezmoi apply
```

### Step 5: Install Missing Tools (if prompted)

When you first open PowerShell, the profile will check for required tools and show you what's missing:

```
⚠ Missing recommended tools:
  • Starship: winget install Starship.Starship
  • GuiCompletion: Install-Module -Name GuiCompletion -Scope CurrentUser
```

Just run the suggested commands to install what you need.

**Done!** Your PowerShell is now configured.

### Step 6: Install Nerd Font (Optional but Recommended)

For proper icon display in the Starship prompt:

1. Download a Nerd Font: [www.nerdfonts.com](https://www.nerdfonts.com/)
2. Install it on your system
3. Set your terminal to use the font:
   - **Windows Terminal**: Settings → Profiles → Defaults → Font face
   - **VS Code**: Settings → Terminal Font Family
   - **iTerm2/Terminal.app**: Preferences → Profiles → Text → Font

---

## 🔄 Import Changes on Existing Machine

If you already have this profile installed and want to pull the latest changes:

### Quick Update

```bash
# Pull latest changes from your repository
chezmoi update

# Or step-by-step:
chezmoi git pull        # Pull changes from remote
chezmoi diff            # Review what will change
chezmoi apply           # Apply the changes
```

### Force Reset (Overwrite Local Changes)

If you want to completely reset to match the repository:

```bash
# WARNING: This will overwrite any local customizations
chezmoi git pull --rebase
chezmoi apply --force
```

### Manual Sync Without chezmoi

If you're not using chezmoi, update files manually:

**Windows:**
```powershell
# Navigate to your repo
cd C:\path\to\chezmoi_profile

# Pull latest changes
git pull

# Copy profiles
Copy-Item "Documents\WindowsPowerShell\*.ps1" "$HOME\Documents\WindowsPowerShell\" -Force
Copy-Item "dot_config\starship.toml" "$HOME\.config\starship.toml" -Force

# Reload profile
. $PROFILE
```

**macOS/Linux:**
```bash
# Navigate to your repo
cd ~/path/to/chezmoi_profile

# Pull latest changes
git pull

# Copy profiles
cp Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/
cp Documents/WindowsPowerShell/Microsoft.VSCode_profile.ps1 ~/.config/powershell/
cp dot_config/starship.toml ~/.config/

# Reload profile
. $PROFILE
```

---

## 📁 What Gets Installed Where

### Windows
```
$HOME\Documents\WindowsPowerShell\
  ├── Microsoft.PowerShell_profile.ps1    # Main profile
  └── Microsoft.VSCode_profile.ps1        # VS Code/Cursor profile

$HOME\.config\
  └── starship.toml                       # Starship configuration
```

### macOS/Linux
```
~/.config/powershell/
  ├── Microsoft.PowerShell_profile.ps1    # Main profile
  └── Microsoft.VSCode_profile.ps1        # VS Code/Cursor profile

~/.config/
  └── starship.toml                       # Starship configuration
```

---

## 🎯 Available Commands

After installation, you can use:

### Python Virtual Environment
| Command      | Description                                              |
| ------------ | -------------------------------------------------------- |
| `activate`   | Activate Python virtual environment in current directory |
| `deactivate` | Deactivate current Python virtual environment            |

### Navigation
| Command | Description                                    |
| ------- | ---------------------------------------------- |
| `..`    | Go up one directory                            |
| `...`   | Go up two directories                          |
| `....`  | Go up three directories                        |
| `ll`    | Enhanced directory listing (formatted table)   |
| `la`    | List all files including hidden                |
| `open`  | Open current directory in file explorer/finder |

### Git Shortcuts
| Command        | Description                     |
| -------------- | ------------------------------- |
| `gs`           | Git status                      |
| `ga`           | Git add all                     |
| `gc "message"` | Git commit with message         |
| `gp`           | Git push                        |
| `gl`           | Git log (pretty graph, last 10) |
| `gd`           | Git diff                        |

### File Operations
| Command      | Description                            |
| ------------ | -------------------------------------- |
| `touch file` | Create file or update timestamp        |
| `ff pattern` | Find files by name pattern (recursive) |

### Utility Functions
| Command              | Description                           |
| -------------------- | ------------------------------------- |
| `Get-OSPlatform`     | Show current OS (Windows/macOS/Linux) |
| `Command-Exists cmd` | Check if a command is available       |
| `sysinfo`            | Display system information            |
| `ep`                 | Edit PowerShell profile               |
| `reload`             | Reload PowerShell profile             |
| `weather [city]`     | Display weather in terminal           |

### Docker (if installed)
| Command | Description                        |
| ------- | ---------------------------------- |
| `dps`   | Docker ps -a (list all containers) |
| `dimg`  | Docker images                      |
| `dstop` | Stop all Docker containers         |
| `drm`   | Remove all Docker containers       |

### Python Virtual Environment Example

```powershell
# Navigate to your Python project
cd my-python-project

# Activate virtual environment (checks both Windows and Unix paths)
activate

# Your prompt will show (venv) indicator
# ... do your work ...

# Deactivate when done
deactivate
```

### Git Workflow Example

```powershell
# Quick git workflow
gs              # Check status
ga              # Stage all changes
gc "fix: bug"   # Commit
gp              # Push
gl              # View recent commits
```

### Navigation Example

```powershell
# Quick directory navigation
cd /some/deep/path/to/project
...             # Go up 2 directories quickly
ll              # See what's here
open            # Open in file explorer
```

### PSReadLine in Action

```powershell
# Start typing a command you've used before
git st↑         # Press ↑ arrow - searches history for "git st..."
                # Shows "git status" from your history

# Predictive IntelliSense shows suggestions as you type
cd ~/proj       # Suggests recently visited paths
```

---

## 🚀 Optional Enhancements

These modules are detected and loaded automatically if installed:

### Terminal-Icons
Beautiful file and folder icons in directory listings.

```powershell
Install-Module -Name Terminal-Icons -Scope CurrentUser
```

**Result**: Icons appear when you use `ll` or `ls` commands! 🎨

### z (Directory Jumper)
Jump to frequently visited directories instantly.

```powershell
Install-Module -Name z -AllowClobber -Scope CurrentUser
```

**Usage**:
```powershell
# After visiting directories a few times
z documents     # Jumps to ~/Documents
z proj          # Jumps to ~/projects
z dot           # Jumps to ~/.config or wherever you go often
```

**How it works**: The more you visit a directory, the higher it ranks. Just type `z` + part of the path!

---

## 🎨 Starship Prompt Features

Your prompt will show:

- 🏁/🍎/🐧 **OS Icon** - Windows/macOS/Linux indicator
- ⚡ **Admin/Root** - Elevated session indicator
- 📁 **Directory** - Current working directory
- 🌿 **Git Branch** - Current branch and remote tracking
- ⇡⇣ **Git Sync** - Commits ahead/behind remote
- +~✘ **Git Status** - Added, modified, deleted files
- ⏱️ **Duration** - Command execution time (if > 10ms)
- 🕐 **Time** - Current time
- `pwsh`/`bash`/`zsh` **Shell** - Active shell indicator

**Color Scheme:** Flexoki Dark (customizable in `starship.toml`)

---

## 🔧 Troubleshooting

### Profile Not Loading

```powershell
# Check if profile exists
Test-Path $PROFILE

# Check execution policy
Get-ExecutionPolicy

# Fix execution policy if needed (run as admin on Windows)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Manually load profile to see errors
. $PROFILE
```

### Starship Not Showing

```powershell
# Check if Starship is installed
starship --version

# Check config location
Test-Path ~/.config/starship.toml  # macOS/Linux
Test-Path $HOME\.config\starship.toml  # Windows

# Manually reload profile
. $PROFILE
```

### GuiCompletion Not Working

```powershell
# Install manually
Install-Module -Name GuiCompletion -Scope CurrentUser -Force

# Import and activate
Import-Module GuiCompletion
Install-GuiCompletion -Key Tab
```

### Chocolatey Install Fails (Windows)

```powershell
# Run PowerShell as Administrator
# Right-click PowerShell → Run as Administrator

# Then reload profile
. $PROFILE
```

### Chocolatey Permission Errors (Windows)

If you see errors like "Access to the path 'C:\ProgramData\chocolatey\lib-bad' is denied":

```powershell
# Open PowerShell as Administrator
# Right-click PowerShell → Run as Administrator

# Run the built-in repair function
Fix-Chocolatey

# This will:
# - Fix permissions on all Chocolatey directories
# - Test if Chocolatey is working
# - Provide guidance if further action is needed
```

**Alternative:** Use winget instead of Chocolatey:
```powershell
# Install Starship with winget (doesn't require admin after winget is installed)
winget install Starship.Starship
```

### Icons Not Displaying

Install a Nerd Font and configure your terminal to use it (see Step 6 above).

---

## 🎨 Customization

### Edit Your Profile

```powershell
# Open in your editor
code $PROFILE
# or
cursor $PROFILE
# or
notepad $PROFILE
```

### Customize Starship Prompt

Edit the Starship configuration:

**Windows:**
```powershell
code $HOME\.config\starship.toml
```

**macOS/Linux:**
```bash
code ~/.config/starship.toml
```

See [Starship documentation](https://starship.rs/config/) for all options.

### Add Your Own Functions

Add custom functions to the profile files:

```powershell
# Example: Quick git commit
function qc {
    param([string]$message)
    git add -A
    git commit -m $message
    git push
}
```

---

## 📦 What Gets Auto-Installed

### Main PowerShell Profile
- ✅ Package manager (Chocolatey on Windows)
- ✅ Starship prompt
- ✅ GuiCompletion module

### IDE Profile (VS Code/Cursor)
- ℹ️ No installations (assumes tools already exist)
- ℹ️ Loads fast for quick IDE startup

---

## 🔗 Useful Resources

- [Starship Prompt](https://starship.rs/) - Cross-shell prompt customization
- [chezmoi](https://www.chezmoi.io/) - Dotfiles manager
- [PowerShell](https://github.com/PowerShell/PowerShell) - Cross-platform PowerShell
- [Nerd Fonts](https://www.nerdfonts.com/) - Fonts with icons

---

## 📝 Making Changes

### If You Modify Profile on One Machine

```bash
# Navigate to chezmoi source directory
chezmoi cd

# Stage your changes
git add .

# Commit
git commit -m "Updated PowerShell profile"

# Push to your repository
git push

# Exit chezmoi source directory
exit
```

### Pull Changes on Other Machines

```bash
chezmoi update
```

---

**Platform Support:** Windows 10+, macOS 10.15+, Linux (any distro)  
**PowerShell Version:** 7.0+ recommended, 5.1+ supported on Windows
