# PowerShell Installation Script for Java and Maven
# Run this script in PowerShell as Administrator

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Installation Script for Java and Maven" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[ERROR] Please run PowerShell as Administrator!" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    pause
    exit 1
}

# Install Chocolatey if not installed
Write-Host "Step 1: Checking Chocolatey..." -ForegroundColor Yellow
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Failed to install Chocolatey" -ForegroundColor Red
        pause
        exit 1
    }
    Write-Host "[SUCCESS] Chocolatey installed!" -ForegroundColor Green
} else {
    Write-Host "[OK] Chocolatey already installed" -ForegroundColor Green
}

Write-Host ""

# Install Java
Write-Host "Step 2: Installing Java JDK 11..." -ForegroundColor Yellow
choco install openjdk11 -y
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to install Java" -ForegroundColor Red
    pause
    exit 1
}
Write-Host "[SUCCESS] Java installed!" -ForegroundColor Green

Write-Host ""

# Install Maven
Write-Host "Step 3: Installing Maven..." -ForegroundColor Yellow
choco install maven -y
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to install Maven" -ForegroundColor Red
    pause
    exit 1
}
Write-Host "[SUCCESS] Maven installed!" -ForegroundColor Green

Write-Host ""

# Refresh environment
Write-Host "Step 4: Refreshing environment variables..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Installation Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Please close PowerShell and open a NEW window" -ForegroundColor Yellow
Write-Host "Then verify installation:" -ForegroundColor Yellow
Write-Host "  java -version" -ForegroundColor White
Write-Host "  mvn -version" -ForegroundColor White
Write-Host ""
Write-Host "To run tests:" -ForegroundColor Yellow
Write-Host "  cd $PSScriptRoot" -ForegroundColor White
Write-Host "  mvn test" -ForegroundColor White
Write-Host ""
pause
