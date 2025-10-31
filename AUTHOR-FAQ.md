# FAQ: About Commit Authors

## Why do I see the original author's name in commits?

This is **normal and correct** Git behavior!

When you clone or fork a repository:
- ✅ **Repository Owner** = You (on your GitHub)
- ⚠️ **Commit Author** = Original author (who wrote the code)

### Example:

**Original Repository:**
```
Owner: synverge
Commits by: synverge
```

**After you fork/clone:**
```
Owner: your-username  ← YOUR name
Commits by: synverge  ← Original author (preserved)
```

---

## Is this a problem?

**NO!** This is how Git is designed to work.

### Good reasons to keep original author:

1. ✅ **Academic integrity** - Shows who actually wrote the code
2. ✅ **Proper attribution** - Gives credit to original author
3. ✅ **History preservation** - Maintains accurate project history
4. ✅ **Collaboration tracking** - Shows contributions from different people

### For academic assignments:

Most professors **want to see this**! It shows:
- You used proper Git workflow (Fork/Clone)
- You understand version control
- You maintain proper attribution
- The TDD commit history is preserved

---

## When should you change the author?

### ✅ Change author if:

1. You want to practice creating the commits yourself
2. The assignment requires YOU to be the author
3. You're creating a personal portfolio piece
4. You want to show it as your own work

### ❌ Don't change author if:

1. The assignment asks you to fork/clone
2. You want to preserve the original TDD workflow
3. You're collaborating with others
4. You need to show proper Git attribution

---

## How to change commit authors?

We provide **3 scripts** for this:

### Option 1: Change Author After Cloning

**Use:** `change-author.ps1`

```powershell
# First, clone normally
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git
cd CS318_227G-Lab-TDD

# Then change all authors
.\change-author.ps1
```

**What it does:**
- Rewrites all commits
- Changes author to your name
- Keeps the same commit messages and dates
- Preserves the TDD workflow

---

### Option 2: Clone AND Change Author (All-in-One)

**Use:** `clone-and-change-author.ps1` ⭐ Recommended

```powershell
# One command does everything
.\clone-and-change-author.ps1 -Username "john-doe" -FullName "John Doe" -Email "john@example.com"
```

**What it does:**
1. ✅ Clones the repository
2. ✅ Changes all commit authors to YOUR name
3. ✅ Sets up git remote to your repo
4. ✅ Helps you push to GitHub

**Result:**
```
Before:
* 79c5509 - synverge <synverge@email.com> : [GREEN] Update sayHello

After:
* 79c5509 - John Doe <john@example.com> : [GREEN] Update sayHello
```

---

### Option 3: Keep Original Author

**Use:** `clone-quick.ps1` or `fork-and-clone-en.ps1`

This keeps the original author (recommended for most cases).

---

## Step-by-Step: Change Author to Yours

### Full Example:

```powershell
# 1. Download/Clone this repository
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git
cd CS318_227G-Lab-TDD

# 2. Run the all-in-one script
.\clone-and-change-author.ps1

# 3. Enter your information when prompted:
#    - GitHub Username: john-doe
#    - Full Name: John Doe
#    - Email: john@example.com

# 4. Wait for script to:
#    - Clone repository
#    - Change all authors to your name
#    - Configure git

# 5. Create repository on GitHub:
#    - Go to https://github.com/new
#    - Name: my-tdd-lab
#    - DO NOT initialize with README
#    - Click Create

# 6. Press Enter in PowerShell to push

# 7. Done! Check your GitHub:
#    - All commits now show YOUR name
#    - But commit messages still have [RED], [GREEN] markers
#    - TDD workflow is preserved
```

---

## Comparison Table

| Method | Author Name | Commit Messages | TDD Workflow | Use Case |
|--------|-------------|-----------------|--------------|----------|
| **Keep Original** | synverge | Preserved | ✅ Preserved | Show proper Git usage |
| **Change Author** | Your name | Preserved | ✅ Preserved | Show as your work |
| **Create Fresh** | Your name | Your own | ✅ You create | Full ownership |

---

## What Professors Will See

### If you keep original author:

```
Repository: https://github.com/john-doe/CS318_227G-Lab-TDD
Owner: john-doe
Commits:
  * [GREEN] Update sayHello - by synverge
  * [RED] Add failing test - by synverge
  * Initial setup - by synverge
```

**Professor's interpretation:**
- ✅ Student properly forked/cloned
- ✅ Student understands Git workflow
- ✅ TDD history preserved
- ✅ Proper attribution maintained

---

### If you change author:

```
Repository: https://github.com/john-doe/CS318_227G-Lab-TDD
Owner: john-doe
Commits:
  * [GREEN] Update sayHello - by John Doe
  * [RED] Add failing test - by John Doe
  * Initial setup - by John Doe
```

**Professor's interpretation:**
- ✅ Student created TDD workflow themselves
- ✅ Student followed proper TDD process
- ✅ Student committed each step
- ⚠️ May ask: "Did you do this yourself?"

---

## Recommendations

### For Lab Assignments:

**Check assignment requirements first!**

If it says:
- "Fork the repository" → **Keep original author**
- "Clone and submit" → **Keep original author**
- "Create your own TDD commits" → **Change author**
- "Show your Git history" → **Change author**

### When in doubt:

1. **Ask your professor** which they prefer
2. **Keep original author** (safer option)
3. Add a **README note** explaining you forked/cloned

Example README note:
```markdown
# Note
This repository was forked from [CS318_227G-Lab-TDD](https://github.com/synverge/CS318_227G-Lab-TDD)
as part of the TDD lab assignment. Original commits preserved to show proper Git workflow.
```

---

## Technical Details

### What `git filter-branch` does:

```bash
# Changes author for all commits
git filter-branch --env-filter '
    export GIT_AUTHOR_NAME="Your Name"
    export GIT_AUTHOR_EMAIL="your@email.com"
    export GIT_COMMITTER_NAME="Your Name"
    export GIT_COMMITTER_EMAIL="your@email.com"
' --tag-name-filter cat -- --branches --tags
```

**Changes:**
- ✅ Author name
- ✅ Author email
- ✅ Committer name
- ✅ Committer email

**Preserves:**
- ✅ Commit messages
- ✅ Commit dates
- ✅ File changes
- ✅ Commit order
- ✅ Branch structure

---

## Summary

### Three Options:

1. **Keep Original Author** (Easiest)
   ```powershell
   .\clone-quick.ps1 -Username "your-username"
   ```

2. **Change to Your Name** (Recommended for portfolio)
   ```powershell
   .\clone-and-change-author.ps1 -Username "your-username" -FullName "Your Name" -Email "your@email.com"
   ```

3. **Create Fresh Commits** (Most work, full ownership)
   - Follow lab instructions manually
   - Create each commit yourself
   - Takes 30-60 minutes

### Quick Decision Guide:

- **Academic assignment** → Ask professor, default: Keep original
- **Personal portfolio** → Change author
- **Learning Git** → Keep original (shows proper workflow)
- **Job interview project** → Change author
- **Collaboration** → Keep original

---

## Need Help?

If you're unsure which option to choose:

1. Read your assignment instructions carefully
2. Ask your professor/instructor
3. When in doubt, **keep the original author** (it's safer)
4. You can always change it later using `change-author.ps1`

---

**Remember:** There's no "wrong" answer - it depends on your specific use case and requirements!
