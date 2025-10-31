# Change Git Author for All Commits
# This script will rewrite git history to change the author of all commits

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Change Git Commit Author" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Ask for new author information
Write-Host "Enter your information for git commits:" -ForegroundColor Yellow
Write-Host ""
$NEW_NAME = Read-Host "Your Name (e.g. John Doe)"
$NEW_EMAIL = Read-Host "Your Email (e.g. john@example.com)"

if ([string]::IsNullOrWhiteSpace($NEW_NAME) -or [string]::IsNullOrWhiteSpace($NEW_EMAIL)) {
    Write-Host "[ERROR] Name and Email are required!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "New author info:" -ForegroundColor Green
Write-Host "  Name: $NEW_NAME" -ForegroundColor White
Write-Host "  Email: $NEW_EMAIL" -ForegroundColor White
Write-Host ""

# Show current commits
Write-Host "Current commit history:" -ForegroundColor Cyan
git log --pretty=format:"%h - %an <%ae> : %s" --all
Write-Host ""
Write-Host ""

# Confirm
Write-Host "WARNING: This will rewrite git history!" -ForegroundColor Yellow
Write-Host "All commits will be changed to your name." -ForegroundColor Yellow
Write-Host ""
$confirm = Read-Host "Continue? (yes/no)"

if ($confirm -ne "yes") {
    Write-Host "[EXIT] Cancelled" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Rewriting git history..." -ForegroundColor Yellow
Write-Host ""

# Configure git user
git config user.name "$NEW_NAME"
git config user.email "$NEW_EMAIL"

# Rewrite history using filter-branch
git filter-branch -f --env-filter "
    export GIT_AUTHOR_NAME='$NEW_NAME'
    export GIT_AUTHOR_EMAIL='$NEW_EMAIL'
    export GIT_COMMITTER_NAME='$NEW_NAME'
    export GIT_COMMITTER_EMAIL='$NEW_EMAIL'
" --tag-name-filter cat -- --branches --tags

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host " Success! History Rewritten" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "New commit history:" -ForegroundColor Cyan
    git log --pretty=format:"%h - %an <%ae> : %s" --all
    Write-Host ""
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Push to GitHub with --force:" -ForegroundColor White
    Write-Host "   git push origin main --force" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Or if this is a new repo, just push normally:" -ForegroundColor White
    Write-Host "   git push -u origin main" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[ERROR] Failed to rewrite history!" -ForegroundColor Red
}

Write-Host ""
pause
