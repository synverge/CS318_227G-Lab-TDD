# PowerShell Script: Fork and Clone Repository with Commit History
# Script for downloading code with commit history automatically

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Fork & Clone Repository with History" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$ORIGINAL_REPO = "https://github.com/synverge/CS318_227G-Lab-TDD.git"
$REPO_NAME = "CS318_227G-Lab-TDD"

# Ask for username
Write-Host "Enter your information:" -ForegroundColor Yellow
Write-Host ""
$YOUR_USERNAME = Read-Host "Your GitHub Username (e.g. john-doe)"

if ([string]::IsNullOrWhiteSpace($YOUR_USERNAME)) {
    Write-Host "[ERROR] Please enter your GitHub Username!" -ForegroundColor Red
    pause
    exit 1
}

# Ask if want to rename repo
Write-Host ""
Write-Host "Do you want to rename the repository?" -ForegroundColor Yellow
Write-Host "Press Enter to keep the original name: $REPO_NAME" -ForegroundColor Gray
$NEW_REPO_NAME = Read-Host "New name (or press Enter)"

if ([string]::IsNullOrWhiteSpace($NEW_REPO_NAME)) {
    $NEW_REPO_NAME = $REPO_NAME
}

# Ask for method: Fork or Clone+Push
Write-Host ""
Write-Host "Choose method:" -ForegroundColor Yellow
Write-Host "1) Fork on GitHub (Recommended - Easiest)" -ForegroundColor White
Write-Host "2) Clone and Push to New Repo (More flexible)" -ForegroundColor White
Write-Host ""
$CHOICE = Read-Host "Choose (1 or 2)"

if ($CHOICE -eq "1") {
    # Method 1: Fork
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host " Fork Method (on GitHub)" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Follow these steps:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Open web browser and go to:" -ForegroundColor White
    Write-Host "   https://github.com/synverge/$REPO_NAME" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. Click the 'Fork' button at the top-right corner" -ForegroundColor White
    Write-Host ""
    Write-Host "3. Select your account: $YOUR_USERNAME" -ForegroundColor White
    Write-Host ""
    Write-Host "4. Wait for GitHub to fork (about 10 seconds)" -ForegroundColor White
    Write-Host ""
    Write-Host "5. Done! Press Enter to clone to your computer..." -ForegroundColor Green
    pause

    Write-Host ""
    Write-Host "Cloning repository..." -ForegroundColor Yellow
    git clone "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME.git"

    if ($LASTEXITCODE -eq 0) {
        Set-Location $NEW_REPO_NAME
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host " Clone Successful! Check Commit History:" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host ""
        git log --oneline --graph --all
        Write-Host ""
        Write-Host "Repository URL:" -ForegroundColor Yellow
        Write-Host "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Local folder: $(Get-Location)" -ForegroundColor Yellow
    } else {
        Write-Host "[ERROR] Clone failed!" -ForegroundColor Red
        Write-Host "Please check if the fork was successful" -ForegroundColor Yellow
    }

} elseif ($CHOICE -eq "2") {
    # Method 2: Clone + Push
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host " Clone + Push Method" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    # Clone
    Write-Host "Step 1/4: Cloning original repository..." -ForegroundColor Yellow
    git clone $ORIGINAL_REPO $NEW_REPO_NAME

    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Clone failed!" -ForegroundColor Red
        pause
        exit 1
    }

    Set-Location $NEW_REPO_NAME
    Write-Host "[OK] Clone successful!" -ForegroundColor Green
    Write-Host ""

    # Show commits
    Write-Host "Commit History received:" -ForegroundColor Cyan
    git log --oneline --all | Select-Object -First 10
    Write-Host ""

    # Create new repo
    Write-Host "Step 2/4: Create New Repository on GitHub" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Go to: https://github.com/new" -ForegroundColor Cyan
    Write-Host "1. Repository name: $NEW_REPO_NAME" -ForegroundColor White
    Write-Host "2. DO NOT check 'Initialize with README'" -ForegroundColor White
    Write-Host "3. Click 'Create repository'" -ForegroundColor White
    Write-Host ""
    Write-Host "Done? Press Enter to continue..." -ForegroundColor Green
    pause

    # Change remote
    Write-Host ""
    Write-Host "Step 3/4: Changing remote..." -ForegroundColor Yellow
    git remote remove origin
    git remote add origin "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME.git"

    Write-Host "[OK] New remote:" -ForegroundColor Green
    git remote -v
    Write-Host ""

    # Push
    Write-Host "Step 4/4: Pushing to GitHub..." -ForegroundColor Yellow
    Write-Host "(You may need to enter username/password or token)" -ForegroundColor Gray
    Write-Host ""

    git push -u origin main

    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host " Success! Pushed with Commit History" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Your Repository URL:" -ForegroundColor Yellow
        Write-Host "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Check Commit History:" -ForegroundColor Yellow
        git log --oneline --graph --all
    } else {
        Write-Host ""
        Write-Host "[ERROR] Push failed!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "1. Check if you created the repository on GitHub" -ForegroundColor White
        Write-Host "2. Try using Personal Access Token instead of password" -ForegroundColor White
        Write-Host "   Create token at: https://github.com/settings/tokens" -ForegroundColor Cyan
        Write-Host "3. Or try Force push:" -ForegroundColor White
        Write-Host "   git push -u origin main --force" -ForegroundColor Gray
    }

} else {
    Write-Host "[ERROR] Please choose 1 or 2 only!" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
pause
