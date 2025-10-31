# Clone and Change Author - All in One Script
# This script clones the repository, changes all commit authors to yours, and pushes to your GitHub

param(
    [Parameter(Mandatory=$false)]
    [string]$Username = "",

    [Parameter(Mandatory=$false)]
    [string]$Email = "",

    [Parameter(Mandatory=$false)]
    [string]$FullName = "",

    [Parameter(Mandatory=$false)]
    [string]$NewRepoName = "my-tdd-lab"
)

$ErrorActionPreference = "Stop"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Clone and Change Author to Yours" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$ORIGINAL_REPO = "https://github.com/synverge/CS318_227G-Lab-TDD.git"

# Ask for information if not provided
if ([string]::IsNullOrWhiteSpace($Username)) {
    $Username = Read-Host "Your GitHub Username"
}

if ([string]::IsNullOrWhiteSpace($FullName)) {
    $FullName = Read-Host "Your Full Name (e.g. John Doe)"
}

if ([string]::IsNullOrWhiteSpace($Email)) {
    $Email = Read-Host "Your Email (e.g. john@example.com)"
}

if ([string]::IsNullOrWhiteSpace($Username) -or [string]::IsNullOrWhiteSpace($FullName) -or [string]::IsNullOrWhiteSpace($Email)) {
    Write-Host "[ERROR] All information is required!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Your information:" -ForegroundColor Green
Write-Host "  GitHub Username: $Username" -ForegroundColor White
Write-Host "  Full Name: $FullName" -ForegroundColor White
Write-Host "  Email: $Email" -ForegroundColor White
Write-Host "  Repository Name: $NewRepoName" -ForegroundColor White
Write-Host ""

# Check Git
try {
    $gitVersion = git --version
    Write-Host "[OK] Git installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git is not installed!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "1. Clone the original repository" -ForegroundColor White
Write-Host "2. Change ALL commit authors to YOUR name" -ForegroundColor White
Write-Host "3. Help you push to your GitHub repository" -ForegroundColor White
Write-Host ""
Write-Host "Press Enter to continue, or Ctrl+C to cancel..." -ForegroundColor Gray
pause

# Step 1: Clone
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[1/4] Cloning repository..." -ForegroundColor Yellow
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

# Show original commits
Write-Host ""
Write-Host "Original commit history:" -ForegroundColor Cyan
git log --pretty=format:"%h - %an <%ae> : %s" --all | Select-Object -First 10
Write-Host ""
Write-Host ""

# Step 2: Configure git user
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[2/4] Configuring git user..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan

git config user.name "$FullName"
git config user.email "$Email"

Write-Host "[OK] Git configured:" -ForegroundColor Green
Write-Host "  user.name = $FullName" -ForegroundColor White
Write-Host "  user.email = $Email" -ForegroundColor White
Write-Host ""

# Step 3: Rewrite history
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[3/4] Rewriting commit history..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Changing all commit authors to: $FullName <$Email>" -ForegroundColor White
Write-Host "This may take a few seconds..." -ForegroundColor Gray
Write-Host ""

$env:FILTER_BRANCH_SQUELCH_WARNING = "1"

git filter-branch -f --env-filter @"
    export GIT_AUTHOR_NAME='$FullName'
    export GIT_AUTHOR_EMAIL='$Email'
    export GIT_COMMITTER_NAME='$FullName'
    export GIT_COMMITTER_EMAIL='$Email'
"@ --tag-name-filter cat -- --branches --tags 2>$null

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] History rewritten successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "New commit history:" -ForegroundColor Cyan
    git log --pretty=format:"%h - %an <%ae> : %s" --all | Select-Object -First 10
    Write-Host ""
    Write-Host ""
} else {
    Write-Host "[ERROR] Failed to rewrite history!" -ForegroundColor Red
    exit 1
}

# Step 4: Change remote and push
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[4/4] Setting up GitHub repository..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

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

# Push
Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
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
    Write-Host "Check commits on GitHub:" -ForegroundColor Yellow
    Write-Host "https://github.com/$Username/$NewRepoName/commits/main" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "All commits now show YOUR name as author!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Local commit history:" -ForegroundColor Yellow
    git log --pretty=format:"%h - %an <%ae> : %s" --all | Select-Object -First 10
    Write-Host ""
    Write-Host ""
    Write-Host "Project folder: $(Get-Location)" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "[ERROR] Push failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "You can try pushing manually:" -ForegroundColor Yellow
    Write-Host "  git push -u origin main --force" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
pause
