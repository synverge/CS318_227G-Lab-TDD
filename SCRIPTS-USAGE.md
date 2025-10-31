# PowerShell Scripts Usage Guide

## Available Scripts

We have **3 PowerShell scripts** to help you clone this repository with full commit history:

### 1. `fork-and-clone-en.ps1` - Interactive Menu (English)
Interactive script with menu options

### 2. `clone-quick.ps1` - Quick Clone with Parameters
Fast script with command-line parameters support

### 3. `clone-to-new-repo.ps1` - Detailed Clone (Thai/English)
Original script with detailed instructions

---

## Quick Start

### Method 1: Using `clone-quick.ps1` (Recommended)

```powershell
# Open PowerShell
cd C:\path\to\downloaded\repo

# Run with your username
.\clone-quick.ps1 -Username "your-github-username"

# Or specify custom repo name
.\clone-quick.ps1 -Username "your-github-username" -NewRepoName "my-custom-name"
```

### Method 2: Using `fork-and-clone-en.ps1`

```powershell
# Run the script
.\fork-and-clone-en.ps1

# Follow the interactive prompts
```

---

## Step-by-Step Instructions

### Using `clone-quick.ps1`

1. **Download this repository** (as ZIP or git clone)

2. **Open PowerShell**
   - Press `Win + X`
   - Select "Windows PowerShell" or "Terminal"

3. **Navigate to the folder**
   ```powershell
   cd C:\Users\YourName\Downloads\CS318_227G-Lab-TDD
   ```

4. **Run the script**
   ```powershell
   .\clone-quick.ps1 -Username "john-doe"
   ```

5. **Follow the prompts:**
   - Script will clone the repository
   - Create a new folder: `my-tdd-lab`
   - Show you the commit history
   - Ask you to create a GitHub repository

6. **Create GitHub repository:**
   - Go to https://github.com/new
   - Name: `my-tdd-lab` (or what you specified)
   - **DO NOT** check "Initialize with README"
   - Click "Create repository"

7. **Press Enter in PowerShell** to push

8. **Enter credentials:**
   - Username: your GitHub username
   - Password: **Personal Access Token** (NOT your password!)

9. **Done!** Check your GitHub for the new repository with all commits

---

## Common Issues

### Issue 1: Execution Policy Error

```
.\clone-quick.ps1 : File cannot be loaded because running scripts is disabled
```

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue 2: Thai Characters Error (in old script)

```
Missing closing ')' in expression
```

**Solution:** Use the English version:
```powershell
.\fork-and-clone-en.ps1
# or
.\clone-quick.ps1
```

### Issue 3: Authentication Failed

**Solution:** Use Personal Access Token instead of password

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Name: `TDD Lab Clone`
4. Select scopes: ✅ **repo** (all repo permissions)
5. Click "Generate token"
6. **Copy the token immediately!** (You won't see it again)
7. Use this token as your password when pushing

**Example:**
```
Username: john-doe
Password: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  ← Token here
```

### Issue 4: Push Rejected

```
! [rejected] main -> main (fetch first)
```

**Solution:**
```powershell
# Force push (only if you're sure the remote is empty)
git push -u origin main --force
```

---

## Parameters Reference

### `clone-quick.ps1`

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `-Username` | No* | (prompts) | Your GitHub username |
| `-NewRepoName` | No | `my-tdd-lab` | Name for the new repository |

*If not provided, script will prompt for it

### Examples:

```powershell
# Minimal usage (will prompt for username)
.\clone-quick.ps1

# With username only
.\clone-quick.ps1 -Username "alice"

# With both parameters
.\clone-quick.ps1 -Username "alice" -NewRepoName "cs318-assignment"

# Using short parameter names
.\clone-quick.ps1 -U "alice" -N "my-repo"
```

---

## What You'll Get

After running the script successfully, you'll have:

✅ A new repository on your GitHub account
✅ All commit history from the original repository
✅ Local copy on your computer
✅ Properly configured git remote

### Expected Commit History:

```
* 3fec5cb feat: Add PowerShell scripts for easy cloning
* 45d13cd docs: Add comprehensive guides
* 79c5509 [GREEN] Update sayHello to handle null case
* aae2175 [RED] Add failing test for testHelloNull
* 21877af [GREEN] Implement sayHello to pass testHelloBasic
* cb11d2c [RED] Add failing test for testHelloBasic
* d1f2a06 Initial: Setup Maven project and add JUnit 5
```

---

## Verification

### Check Local Commit History:

```powershell
git log --oneline --graph --all
```

### Check on GitHub:

1. Go to: `https://github.com/YOUR-USERNAME/YOUR-REPO-NAME`
2. Click on "**X commits**" (next to the Code button)
3. You should see all 7 commits with TDD markers ([RED], [GREEN])

---

## Alternative: Manual Clone

If scripts don't work, you can clone manually:

```powershell
# 1. Clone the repository
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git my-lab
cd my-lab

# 2. Remove old remote
git remote remove origin

# 3. Add your new remote
git remote add origin https://github.com/YOUR-USERNAME/my-lab.git

# 4. Create repository on GitHub (https://github.com/new)
#    DO NOT initialize with README

# 5. Push
git push -u origin main
```

---

## Tips

### Save Your Personal Access Token

Store it in a text file (in a secure location) so you don't have to create a new one each time.

### Use Git Credential Manager

Windows Git Credential Manager can save your credentials:

```powershell
git config --global credential.helper manager-core
```

Then you only need to enter your token once.

### One-Liner Clone

```powershell
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git my-lab; cd my-lab; git remote remove origin; git remote add origin https://github.com/YOUR-USERNAME/my-lab.git
```

Then just create the repo and push.

---

## Getting Help

If you encounter any issues:

1. Check the error message carefully
2. Read the [CLONE-SCRIPTS-README.md](CLONE-SCRIPTS-README.md) for detailed troubleshooting
3. Verify you completed all steps (especially creating the GitHub repository)
4. Make sure you're using a Personal Access Token, not your password

---

## Summary

**Easiest method for most users:**

```powershell
.\clone-quick.ps1 -Username "your-username"
```

**For interactive menu:**

```powershell
.\fork-and-clone-en.ps1
```

**Both will:**
- Clone with full commit history ✅
- Set up proper git remote ✅
- Guide you through creating GitHub repo ✅
- Push everything automatically ✅

**Time required:** 3-5 minutes
