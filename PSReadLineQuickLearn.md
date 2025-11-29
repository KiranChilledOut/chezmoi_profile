# PSReadLine Quick Reference Guide

> Master PowerShell command-line editing with these keyboard shortcuts

## 🎯 Predictive IntelliSense (Gray Text Suggestions)

| Shortcut | Action |
|----------|--------|
| **→** or **End** | Accept entire suggestion |
| **Ctrl + →** | Accept one word at a time |
| **F2** | Accept suggestion and execute immediately |
| **Esc** | Dismiss suggestion |

---

## 📋 ListView (Dropdown Menu)

| Shortcut | Action |
|----------|--------|
| *(wait 1-2 sec after typing)* | Show dropdown list of matching commands |
| **↑** / **↓** | Navigate up/down in the list |
| **Enter** or **→** | Select highlighted command |
| **Esc** | Close the list |

---

## 🔍 History Search

| Shortcut | Action |
|----------|--------|
| **↑** | Search backward (commands starting with what you typed) |
| **↓** | Search forward (commands starting with what you typed) |
| **F8** | Search anywhere in command (not just beginning) 🔥 |
| **Shift + F8** | Reverse search with F8 |
| **Ctrl + R** | Interactive reverse history search |

---

## 🚀 Navigation (Moving Around)

| Shortcut | Action |
|----------|--------|
| **Ctrl + →** | Jump forward one word |
| **Ctrl + ←** | Jump backward one word |
| **Home** | Jump to start of line |
| **End** | Jump to end of line |
| **←** / **→** | Move one character left/right |

---

## ✂️ Editing & Deletion

| Shortcut | Action |
|----------|--------|
| **Ctrl + Backspace** | Delete word before cursor |
| **Ctrl + Delete** | Delete word after cursor |
| **Ctrl + Home** | Delete from cursor to start of line |
| **Ctrl + End** | Delete from cursor to end of line |
| **Ctrl + U** | Delete entire line |
| **Ctrl + K** | Delete from cursor to end of line (alt) |
| **Backspace** | Delete character before cursor |
| **Delete** | Delete character after cursor |

---

## ⏮️ Undo / Redo

| Shortcut | Action |
|----------|--------|
| **Ctrl + Z** | Undo last change |
| **Ctrl + Y** | Redo |

---

## 🎨 Selection & Clipboard

| Shortcut | Action |
|----------|--------|
| **Ctrl + A** | Select entire line |
| **Shift + →** / **←** | Select character by character |
| **Shift + Ctrl + →** / **←** | Select word by word |
| **Ctrl + C** | Copy selection (or cancel if nothing selected) |
| **Ctrl + X** | Cut selection |
| **Ctrl + V** | Paste |

---

## 🔥 Pro Power User Tricks

| Shortcut | Action |
|----------|--------|
| **Alt + .** | Insert last argument from previous command 🔥 |
| **Alt + .** *(press again)* | Cycle through previous arguments |
| **Ctrl + Space** | Show all possible completions |
| **Ctrl + D** | Exit PowerShell (Unix-like) |
| **Ctrl + L** | Clear screen |
| **Tab** | Cycle through completions |
| **Shift + Tab** | Cycle backwards through completions |
| **Ctrl + ]** | Jump to matching bracket |

---

## 💡 Quick Scenarios

### Scenario 1: Repeat a Long Command
```
1. Type first few letters
2. Wait for ListView or gray suggestion
3. Press → or F2
```

### Scenario 2: Find Command from Yesterday
```
1. Type: git s
2. Press: F8 (searches anywhere)
3. Keep pressing F8 to cycle through matches
```

### Scenario 3: Edit Middle of Long Command
```
1. Press: Home (go to start)
2. Press: Ctrl + → (jump to word you want to change)
3. Press: Ctrl + Delete (delete that word)
4. Type: new word
5. Press: Ctrl + Z (if you made a mistake)
```

### Scenario 4: Reuse Path from Previous Command
```
1. Run: ls C:\Some\Long\Path
2. Type: cd 
3. Press: Alt + .
4. Result: cd C:\Some\Long\Path
```

### Scenario 5: Quick Command Modification
```
1. Press: ↑ (get last command)
2. Press: Home (go to start)
3. Press: Ctrl + → (jump words)
4. Edit what you need
5. Press: Enter
```

---

## 🎯 Most Used Shortcuts (Start Here!)

If you only learn 5, learn these:

1. **F8** - Search history anywhere in command
2. **Ctrl + →** / **←** - Jump by word
3. **Ctrl + Backspace** - Delete word backward
4. **Alt + .** - Paste last argument
5. **Ctrl + Z** - Undo

---

## 🎓 Practice Exercise

Try this sequence to master the basics:

```powershell
# 1. Type a long command
Get-ChildItem -Path C:\Windows -Recurse -Filter *.log

# 2. Press ↑ to recall it
# 3. Press Home to go to start
# 4. Press Ctrl + → three times to jump to "C:\Windows"
# 5. Press Ctrl + Delete to delete "C:\Windows"
# 6. Type: C:\Temp
# 7. Press Ctrl + Z to undo
# 8. Press Ctrl + End to delete rest of line
```

---

## 📚 Learn More

- Official PSReadLine: `Get-Help about_PSReadLine`
- List all key bindings: `Get-PSReadLineKeyHandler`
- Your current settings: `Get-PSReadLineOption`

---

**🚀 Pro Tip:** The more you use these shortcuts, the faster you'll get. Focus on learning 2-3 at a time until they become muscle memory!

**Created:** $(Get-Date -Format 'yyyy-MM-dd')  
**PSReadLine Version:** Check with `Get-Module PSReadLine`

