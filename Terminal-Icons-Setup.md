# Terminal-Icons Setup Guide

> Beautiful file and folder icons in your PowerShell terminal

## 🎨 What is Terminal-Icons?

Terminal-Icons adds colorful icons to files and folders in your directory listings, making it easier to identify file types at a glance.

**Before:**
```
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          11/29/2025  11:30 PM                Documents
-a---          11/29/2025  11:30 PM           1024 config.json
-a---          11/29/2025  11:30 PM           2048 script.ps1
```

**After (with Terminal-Icons):**
```
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          11/29/2025  11:30 PM                📁 Documents
-a---          11/29/2025  11:30 PM           1024 📄 config.json
-a---          11/29/2025  11:30 PM           2048 📜 script.ps1
```

---

## 🌍 Cross-Platform Support

| OS | Supported? | Notes |
|----|------------|-------|
| **Windows** | ✅ Yes | Works in Windows Terminal, VS Code, Cursor |
| **macOS** | ✅ Yes | Works in Terminal.app, iTerm2, VS Code |
| **Linux** | ✅ Yes | Works in GNOME Terminal, Konsole, VS Code |

**Requirements:**
- PowerShell 7+ (cross-platform)
- A **Nerd Font** (for proper icon display)

---

## 📦 Installation

### Step 1: Install Terminal-Icons Module

**All Platforms:**
```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
```

### Step 2: Install a Nerd Font

**Why?** Nerd Fonts contain the icon glyphs that Terminal-Icons uses.

#### Recommended Nerd Fonts:
- **CaskaydiaCove Nerd Font** (Cascadia Code + icons)
- **FiraCode Nerd Font**
- **JetBrainsMono Nerd Font**
- **Meslo Nerd Font**

#### Download & Install:

**Windows:**
1. Go to [Nerd Fonts Releases](https://github.com/ryanoasis/nerd-fonts/releases)
2. Download your preferred font (e.g., `CascadiaCode.zip`)
3. Extract and double-click `.ttf` files
4. Click "Install"

**macOS:**
```bash
# Using Homebrew
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font

# Or download manually from nerdfonts.com
```

**Linux:**
```bash
# Ubuntu/Debian
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
# Download and extract font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip
unzip CascadiaCode.zip
fc-cache -fv
```

---

## ⚙️ Configure Your Terminal

After installing the font, configure your terminal to use it:

### Windows Terminal
1. Open Settings (Ctrl + ,)
2. Go to **Defaults** → **Appearance**
3. Set **Font face** to: `CaskaydiaCove Nerd Font` (or your chosen font)
4. Save

### VS Code
1. Open Settings (Ctrl + ,)
2. Search for: `terminal.integrated.fontFamily`
3. Set to: `'CaskaydiaCove Nerd Font', monospace`
4. Restart VS Code

### Cursor
1. Open Settings
2. Search for: `terminal.integrated.fontFamily`
3. Set to: `'CaskaydiaCove Nerd Font', monospace`
4. Restart Cursor

### iTerm2 (macOS)
1. Preferences → Profiles → Text
2. Change **Font** to your Nerd Font
3. Restart iTerm2

### GNOME Terminal (Linux)
1. Preferences → Profile → Text
2. Uncheck "Use system fixed width font"
3. Select your Nerd Font
4. Close preferences

---

## ✅ Verify Installation

**Test if Terminal-Icons is working:**

```powershell
# Reload your profile
. $PROFILE

# List files - you should see icons!
ls

# Or use our alias
ll
```

**Check module is loaded:**
```powershell
Get-Module Terminal-Icons
```

**Test font is working:**
```powershell
# Should display various icons
echo "      󰈚         "
```

If you see boxes (□) or question marks (?), your font isn't configured correctly.

---

## 🎨 Icon Examples

Terminal-Icons shows different icons for:

- 📁 Directories
- 📄 Text files
- 🖼️ Images (png, jpg, gif)
- 📜 Scripts (ps1, sh, py)
- ⚙️ Config files (json, xml, yml)
- 📦 Archives (zip, tar, 7z)
- 🎵 Media files (mp3, mp4, avi)
- 💾 Databases (db, sql)
- 🔒 Encrypted files
- And many more!

---

## 🔧 Customization

### Change Icon Theme

Terminal-Icons comes with multiple themes:

```powershell
# List available themes
Get-TerminalIconsTheme

# Set a theme
Set-TerminalIconsTheme -Name devblackops

# Available themes:
# - devblackops (default, colorful)
# - jaykul (alternative colors)
```

### Add to Profile (Already Done!)

Your profile already loads Terminal-Icons automatically if installed:

```powershell
if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Import-Module Terminal-Icons -ErrorAction SilentlyContinue
}
```

---

## 🐛 Troubleshooting

### Icons show as boxes or ??
**Problem:** Font not configured or not a Nerd Font  
**Solution:** 
1. Verify you installed a **Nerd Font** (not regular font)
2. Configure terminal to use that font
3. Restart terminal

### Module not found
**Problem:** Module not installed  
**Solution:**
```powershell
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
```

### Icons not showing in VS Code
**Problem:** VS Code using different font  
**Solution:**
1. Open VS Code settings
2. Set `terminal.integrated.fontFamily`
3. Restart VS Code

### Works in one terminal but not another
**Problem:** Each terminal has its own font settings  
**Solution:** Configure font in each terminal separately

---

## 📚 Learn More

- **GitHub:** [Terminal-Icons Repository](https://github.com/devblackops/Terminal-Icons)
- **Nerd Fonts:** [nerdfonts.com](https://www.nerdfonts.com/)
- **Supported Glyphs:** Check what icons are available in your font

---

## 🎯 Quick Setup Checklist

- [ ] Install PowerShell 7+
- [ ] Install Terminal-Icons module
- [ ] Download & Install a Nerd Font
- [ ] Configure terminal to use Nerd Font
- [ ] Restart terminal
- [ ] Run `ls` to see icons!
- [ ] Enjoy beautiful file listings! 🎨

---

**Pro Tip:** Once you get used to icons, you'll never want to go back! They make scanning directories SO much faster. 🚀

**Created:** For cross-platform PowerShell profile  
**Compatible:** Windows, macOS, Linux with PowerShell 7+

