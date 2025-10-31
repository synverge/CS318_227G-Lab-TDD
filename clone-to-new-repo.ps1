# PowerShell Script: Clone และ Push ไปที่ Repository ใหม่แบบเร็ว
# ใช้สำหรับ Clone โค้ดพร้อม commit history แล้ว push ไปที่ repo ของตัวเอง

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

# ตั้งค่า
$ORIGINAL_REPO = "https://github.com/synverge/CS318_227G-Lab-TDD.git"

# ถาม username ถ้ายังไม่ได้ระบุ
if ([string]::IsNullOrWhiteSpace($Username)) {
    $Username = Read-Host "GitHub Username ของคุณ"
    if ([string]::IsNullOrWhiteSpace($Username)) {
        Write-Host "[ERROR] กรุณากรอก GitHub Username!" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Username: $Username" -ForegroundColor Green
Write-Host "Repository Name: $NewRepoName" -ForegroundColor Green
Write-Host ""

# ตรวจสอบว่ามี Git หรือไม่
try {
    $gitVersion = git --version
    Write-Host "[OK] Git installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git ไม่ได้ติดตั้ง!" -ForegroundColor Red
    Write-Host "กรุณาติดตั้ง Git จาก: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "ขั้นตอนที่จะทำ:" -ForegroundColor Yellow
Write-Host "1. Clone repository ต้นฉบับ (พร้อม commit history)" -ForegroundColor White
Write-Host "2. เปลี่ยน remote ไปยัง repository ของคุณ" -ForegroundColor White
Write-Host "3. Push ทุกอย่างขึ้น GitHub" -ForegroundColor White
Write-Host ""
Write-Host "กด Enter เพื่อดำเนินการต่อ, หรือ Ctrl+C เพื่อยกเลิก..." -ForegroundColor Gray
pause

# ขั้นที่ 1: Clone
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[1/3] กำลัง Clone repository..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan

if (Test-Path $NewRepoName) {
    Write-Host "[WARNING] โฟลเดอร์ '$NewRepoName' มีอยู่แล้ว!" -ForegroundColor Yellow
    $overwrite = Read-Host "ต้องการลบและสร้างใหม่? (y/n)"
    if ($overwrite -eq "y") {
        Remove-Item -Path $NewRepoName -Recurse -Force
        Write-Host "[OK] ลบโฟลเดอร์เดิมแล้ว" -ForegroundColor Green
    } else {
        Write-Host "[EXIT] ยกเลิกการทำงาน" -ForegroundColor Yellow
        exit 0
    }
}

git clone $ORIGINAL_REPO $NewRepoName

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Clone ไม่สำเร็จ!" -ForegroundColor Red
    exit 1
}

Set-Location $NewRepoName
Write-Host "[OK] Clone สำเร็จ!" -ForegroundColor Green

# แสดง commit history
Write-Host ""
Write-Host "Commit History ที่ได้:" -ForegroundColor Cyan
git log --oneline --graph --all | Select-Object -First 10
Write-Host ""

# ขั้นที่ 2: เปลี่ยน remote
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[2/3] กำลังเปลี่ยน remote..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan

git remote remove origin
git remote add origin "https://github.com/$Username/$NewRepoName.git"

Write-Host "[OK] Remote ใหม่:" -ForegroundColor Green
git remote -v
Write-Host ""

# แจ้งให้สร้าง repo
Write-Host "================================================" -ForegroundColor Yellow
Write-Host " สร้าง Repository บน GitHub" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "กรุณาทำตามขั้นตอนนี้:" -ForegroundColor White
Write-Host ""
Write-Host "1. เปิดเว็บเบราว์เซอร์ไปที่:" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. กรอกข้อมูล:" -ForegroundColor White
Write-Host "   - Repository name: $NewRepoName" -ForegroundColor Gray
Write-Host "   - Description: (เว้นว่างได้)" -ForegroundColor Gray
Write-Host "   - Public หรือ Private: (เลือกตามต้องการ)" -ForegroundColor Gray
Write-Host "   - อย่าติ๊ก 'Initialize this repository with a README'" -ForegroundColor Red
Write-Host ""
Write-Host "3. คลิก 'Create repository'" -ForegroundColor White
Write-Host ""
Write-Host "เสร็จแล้วกด Enter เพื่อ Push..." -ForegroundColor Green
pause

# ขั้นที่ 3: Push
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "[3/3] กำลัง Push ไปที่ GitHub..." -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "หมายเหตุ: อาจต้องกรอก username/password หรือ Personal Access Token" -ForegroundColor Gray
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host " สำเร็จ! " -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Repository ของคุณ:" -ForegroundColor Yellow
    Write-Host "https://github.com/$Username/$NewRepoName" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "ตรวจสอบ Commit History ได้ที่:" -ForegroundColor Yellow
    Write-Host "https://github.com/$Username/$NewRepoName/commits/main" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Commit History ในเครื่อง:" -ForegroundColor Yellow
    git log --oneline --graph --all
    Write-Host ""
    Write-Host "โฟลเดอร์โปรเจค: $(Get-Location)" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "[ERROR] Push ไม่สำเร็จ!" -ForegroundColor Red
    Write-Host ""
    Write-Host "วิธีแก้ปัญหา:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Authentication Error:" -ForegroundColor White
    Write-Host "   - ใช้ Personal Access Token แทน password" -ForegroundColor Gray
    Write-Host "   - สร้าง Token: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "   - เลือก: repo (Full control of private repositories)" -ForegroundColor Gray
    Write-Host "   - Copy token แล้วนำมาใช้แทน password" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Repository ไม่พบ:" -ForegroundColor White
    Write-Host "   - ตรวจสอบว่าสร้าง repository บน GitHub แล้ว" -ForegroundColor Gray
    Write-Host "   - ตรวจสอบชื่อ repository ให้ตรงกับที่ตั้งไว้" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. ลองใช้ Force Push (ถ้าแน่ใจ):" -ForegroundColor White
    Write-Host "   git push -u origin main --force" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
pause
