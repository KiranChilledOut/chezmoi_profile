# 🎨 Terminal-Icons Quick Setup Guide

Terminal-Icons is a PowerShell module that displays beautiful file and folder icons in your terminal. This guide will help you set it up properly.

---

## 📋 What You Need

1. **Nerd Font** - A font that contains icon glyphs
2. **Terminal-Icons Module** - PowerShell module (already in your profile)
3. **Font Configuration** - Set your terminal to use the Nerd Font

---

## 🚀 Quick Setup (3 Steps)

### Step 1: Install a Nerd Font

Download and install one of these Nerd Fonts:

- **CaskaydiaCove Nerd Font** (Recommended) - [Download](https://github.com/ryanoasis/nerd-fonts/releases/latest)
- **Cascadia Code NF** - [Download from Microsoft](https://github.com/microsoft/cascadia-code/releases)

After downloading:
1. Extract the `.zip` file
2. Right-click on the `.ttf` font files
3. Click "Install" or "Install for all users"

---

### Step 2: Configure Windows Terminal Font

> **⚠️ IMPORTANT:** Without this step, you'll see empty boxes (▯) instead of icons!

1. Open **Windows Terminal**
2. Press `Ctrl+,` to open Settings
3. In the left sidebar, select **PowerShell** (or your profile)
4. Click **Appearance**
5. Under **Font face**, select: **CaskaydiaCove Nerd Font** (or **Cascadia Code NF**)
6. Click **Save**
7. **Close and reopen** Windows Terminal

**Screenshot Guide:**
```
Settings → PowerShell → Appearance → Font face → CaskaydiaCove Nerd Font
```

---

### Step 3: Test Icons

After restarting your terminal, run:

```powershell
ls
```

You should now see:
- 📁 Folder icons
- 📄 File icons (different for .ps1, .md, .json, etc.)
- 🎨 Color-coded based on file type

---

## 🔍 Troubleshooting

### Problem: Still seeing empty boxes (▯)

**Solution:**
- Make sure you selected the **Nerd Font** (CaskaydiaCove Nerd Font or Cascadia Code NF)
- **NOT** the regular "Cascadia Code" or "Cascadia Mono"
- Restart Windows Terminal completely

### Problem: Icons not showing in VS Code/Cursor

**Solution:**
1. Press `Ctrl+,` to open Settings
2. Search for: `terminal.integrated.fontFamily`
3. Set to: `"CaskaydiaCove Nerd Font"`
4. Restart VS Code/Cursor

### Problem: Module not found error

**Solution:**
```powershell
# Install Terminal-Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser

# Reload profile
. $PROFILE
```

---

## 📚 Understanding Glyphs

**What are Glyphs?**
Customized command prompts often use glyphs (graphic symbols) to style the prompt. If your font doesn't include the appropriate glyphs, you may see several Unicode replacement characters '▯' in your prompt.

**Why Nerd Fonts?**
Nerd Fonts are patched fonts that include thousands of icon glyphs from popular icon sets like:
- Font Awesome
- Material Design Icons
- Devicons
- Powerline symbols

To see all glyphs in your terminal, you **must** use a Nerd Font.

---

## 🎯 Supported Terminals

Terminal-Icons works with:
- ✅ **Windows Terminal** (Recommended)
- ✅ **VS Code Integrated Terminal**
- ✅ **Cursor IDE Terminal**
- ✅ **PowerShell ISE** (limited icon support)
- ✅ **ConEmu**
- ✅ **Cmder**

---

## 🔗 Additional Resources

- [Microsoft Terminal Setup Guide](https://learn.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup)
- [Terminal-Icons GitHub](https://github.com/devblackops/Terminal-Icons)
- [Nerd Fonts Official Site](https://www.nerdfonts.com/)
- [Cascadia Code Releases](https://github.com/microsoft/cascadia-code/releases)

---

## ⚙️ Already Configured in Your Profile

Your PowerShell profile already includes Terminal-Icons:

```powershell
# Terminal-Icons module (if installed)
if (Get-Module -ListAvailable -Name Terminal-Icons) {
    try {
        Import-Module Terminal-Icons -ErrorAction SilentlyContinue
    }
    catch {
        # Silently continue if it fails
    }
}
```

**No profile changes needed!** Just configure the font in your terminal settings.

---

## 🎨 Example: What You'll See

**Before (without Nerd Font):**
```
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----        30-11-2025     00:00                Documents
-a---        30-11-2025     00:00           1234  script.ps1
```

**After (with Nerd Font):**
```
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----        30-11-2025     00:00                 Documents
-a---        30-11-2025     00:00           1234  script.ps1
```
(Icons will appear as actual graphics in your terminal)

---

## 💡 Pro Tips

1. **CaskaydiaCove vs Cascadia Code:**
   - `CaskaydiaCove Nerd Font` = Patched with icons ✅
   - `Cascadia Code` = No icons ❌

2. **Font Size:**
   - Recommended: 10-12pt for best icon visibility
   - Too small = hard to see icons
   - Too large = takes up screen space

3. **Check if Font is Active:**
   ```powershell
   Get-TerminalIconsGlyphs | Select-Object -First 5
   ```
   If you see actual icons (not boxes), your font is working!

---

## ✅ Quick Checklist

- [ ] Nerd Font downloaded and installed on Windows
- [ ] Windows Terminal font face set to Nerd Font
- [ ] Terminal restarted completely
- [ ] `ls` command shows icons
- [ ] VS Code/Cursor font configured (if using those)

---

**That's it!** Terminal-Icons should now be working perfectly. Enjoy your beautiful terminal! 🎉


