# Quick Clone Script - Clone repository with commit history
# Usage: .\clone-quick.ps1 -Username "your-username" -NewRepoName "my-repo"

param(
    [Parameter(Mandatory=$false)]
    [string]$Username = "",

    [Parameter(Mandatory=$false)]
    [string]$NewRepoName = "my-tdd-lab"
)

$ErrorActionPreference = "Stop"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Quick Clone to New Repository" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$ORIGINAL_REPO = "https://github.com/synverge/CS318_227G-Lab-TDD.git"

# Ask for username if not provided
if ([string]::IsNullOrWhiteSpace($Username)) {
    $Username = Read-Host "Your GitHub Username"
    if ([string]::IsNullOrWhiteSpace($Username)) {
        Write-Host "[ERROR] Please enter your GitHub Username!" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Username: $Username" -ForegroundColor Green
Write-Host "Repository Name: $NewRepoName" -ForegroundColor Green
Write-Host ""

# Check if Git is installed
try {
    $gitVersion = git --version
    Write-Host "[OK] Git installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git is not installed!" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Steps to perform:" -ForegroundColor Yellow
Write-Host "1. Clone original repository (with commit history)" -ForegroundColor White
Write-Host "2. Change remote to your repository" -ForegroundColor White
Write-Host "3. Push everything to GitHub" -ForegroundColor White
Write-Host ""
Write-Host "Press Enter to continue, or Ctrl+C to cancel..." -ForegroundColor Gray
pause

# Step 1: Clone
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[1/3] Cloning repository..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan

if (Test-Path $NewRepoName) {
    Write-Host "[WARNING] Folder '$NewRepoName' already exists!" -ForegroundColor Yellow
    $overwrite = Read-Host "Delete and create new? (y/n)"
    if ($overwrite -eq "y") {
        Remove-Item -Path $NewRepoName -Recurse -Force
        Write-Host "[OK] Deleted old folder" -ForegroundColor Green
    } else {
        Write-Host "[EXIT] Cancelled" -ForegroundColor Yellow
        exit 0
    }
}

git clone $ORIGINAL_REPO $NewRepoName

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Clone failed!" -ForegroundColor Red
    exit 1
}

Set-Location $NewRepoName
Write-Host "[OK] Clone successful!" -ForegroundColor Green

# Show commit history
Write-Host ""
Write-Host "Commit History received:" -ForegroundColor Cyan
git log --oneline --graph --all | Select-Object -First 10
Write-Host ""

# Step 2: Change remote
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[2/3] Changing remote..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan

git remote remove origin
git remote add origin "https://github.com/$Username/$NewRepoName.git"

Write-Host "[OK] New remote:" -ForegroundColor Green
git remote -v
Write-Host ""

# Notify to create repo
Write-Host "================================================" -ForegroundColor Yellow
Write-Host " Create Repository on GitHub" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please follow these steps:" -ForegroundColor White
Write-Host ""
Write-Host "1. Open web browser and go to:" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Fill in the form:" -ForegroundColor White
Write-Host "   - Repository name: $NewRepoName" -ForegroundColor Gray
Write-Host "   - Description: (optional)" -ForegroundColor Gray
Write-Host "   - Public or Private: (your choice)" -ForegroundColor Gray
Write-Host "   - DO NOT check 'Initialize this repository with a README'" -ForegroundColor Red
Write-Host ""
Write-Host "3. Click 'Create repository'" -ForegroundColor White
Write-Host ""
Write-Host "Done? Press Enter to Push..." -ForegroundColor Green
pause

# Step 3: Push
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[3/3] Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Note: You may need to enter username/password or Personal Access Token" -ForegroundColor Gray
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host " SUCCESS! " -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your repository:" -ForegroundColor Yellow
    Write-Host "https://github.com/$Username/$NewRepoName" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Check Commit History at:" -ForegroundColor Yellow
    Write-Host "https://github.com/$Username/$NewRepoName/commits/main" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Local Commit History:" -ForegroundColor Yellow
    git log --oneline --graph --all
    Write-Host ""
    Write-Host "Project folder: $(Get-Location)" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "[ERROR] Push failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Authentication Error:" -ForegroundColor White
    Write-Host "   - Use Personal Access Token instead of password" -ForegroundColor Gray
    Write-Host "   - Create Token: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "   - Select: repo (Full control of private repositories)" -ForegroundColor Gray
    Write-Host "   - Copy token and use it as password" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Repository not found:" -ForegroundColor White
    Write-Host "   - Check if you created the repository on GitHub" -ForegroundColor Gray
    Write-Host "   - Check if repository name matches" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. Try Force Push (if you are sure):" -ForegroundColor White
    Write-Host "   git push -u origin main --force" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
pause
