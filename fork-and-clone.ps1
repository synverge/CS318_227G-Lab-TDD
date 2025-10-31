# PowerShell Script: Fork and Clone Repository with Commit History
# สคริปต์สำหรับโหลดโค้ดพร้อม commit history แบบอัตโนมัติ

Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Fork & Clone Repository with History" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# ตั้งค่า
$ORIGINAL_REPO = "https://github.com/synverge/CS318_227G-Lab-TDD.git"
$REPO_NAME = "CS318_227G-Lab-TDD"

# ถาม username
Write-Host "กรอกข้อมูลของคุณ:" -ForegroundColor Yellow
Write-Host ""
$YOUR_USERNAME = Read-Host "GitHub Username ของคุณ (เช่น john-doe)"

if ([string]::IsNullOrWhiteSpace($YOUR_USERNAME)) {
    Write-Host "[ERROR] กรุณากรอก GitHub Username!" -ForegroundColor Red
    pause
    exit 1
}

# ถามว่าต้องการเปลี่ยนชื่อ repo หรือไม่
Write-Host ""
Write-Host "ต้องการเปลี่ยนชื่อ repository หรือไม่?" -ForegroundColor Yellow
Write-Host "กด Enter เพื่อใช้ชื่อเดิม: $REPO_NAME" -ForegroundColor Gray
$NEW_REPO_NAME = Read-Host "ชื่อใหม่ (หรือกด Enter)"

if ([string]::IsNullOrWhiteSpace($NEW_REPO_NAME)) {
    $NEW_REPO_NAME = $REPO_NAME
}

# ถามว่าต้องการ Fork หรือ Clone + Push
Write-Host ""
Write-Host "เลือกวิธีการ:" -ForegroundColor Yellow
Write-Host "1) Fork บน GitHub (แนะนำ - ง่ายที่สุด)" -ForegroundColor White
Write-Host "2) Clone แล้ว Push ไปที่ Repo ใหม่ (ยืดหยุ่นกว่า)" -ForegroundColor White
Write-Host ""
$CHOICE = Read-Host "เลือก (1 หรือ 2)"

if ($CHOICE -eq "1") {
    # วิธีที่ 1: Fork
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host " วิธี Fork (ทำบน GitHub)" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "ทำตามขั้นตอนนี้:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. เปิดเว็บเบราว์เซอร์แล้วไปที่:" -ForegroundColor White
    Write-Host "   https://github.com/synverge/$REPO_NAME" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. คลิกปุ่ม 'Fork' ที่มุมขวาบน" -ForegroundColor White
    Write-Host ""
    Write-Host "3. เลือก account: $YOUR_USERNAME" -ForegroundColor White
    Write-Host ""
    Write-Host "4. รอให้ GitHub ทำการ Fork (ประมาณ 10 วินาที)" -ForegroundColor White
    Write-Host ""
    Write-Host "5. เสร็จแล้ว! กด Enter เพื่อ Clone ลงเครื่อง..." -ForegroundColor Green
    pause

    Write-Host ""
    Write-Host "กำลัง Clone repository..." -ForegroundColor Yellow
    git clone "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME.git"

    if ($LASTEXITCODE -eq 0) {
        Set-Location $NEW_REPO_NAME
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host " Clone สำเร็จ! ตรวจสอบ Commit History:" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host ""
        git log --oneline --graph --all
        Write-Host ""
        Write-Host "Repository URL:" -ForegroundColor Yellow
        Write-Host "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "โฟลเดอร์: $(Get-Location)" -ForegroundColor Yellow
    } else {
        Write-Host "[ERROR] Clone ไม่สำเร็จ!" -ForegroundColor Red
        Write-Host "กรุณาตรวจสอบว่า Fork สำเร็จแล้วหรือยัง" -ForegroundColor Yellow
    }

} elseif ($CHOICE -eq "2") {
    # วิธีที่ 2: Clone + Push
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host " วิธี Clone + Push" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    # Clone
    Write-Host "Step 1/4: กำลัง Clone repository ต้นฉบับ..." -ForegroundColor Yellow
    git clone $ORIGINAL_REPO $NEW_REPO_NAME

    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Clone ไม่สำเร็จ!" -ForegroundColor Red
        pause
        exit 1
    }

    Set-Location $NEW_REPO_NAME
    Write-Host "[OK] Clone สำเร็จ!" -ForegroundColor Green
    Write-Host ""

    # แสดง commits
    Write-Host "Commit History ที่ได้:" -ForegroundColor Cyan
    git log --oneline --all | Select-Object -First 10
    Write-Host ""

    # สร้าง repo ใหม่
    Write-Host "Step 2/4: สร้าง Repository ใหม่บน GitHub" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "ไปที่: https://github.com/new" -ForegroundColor Cyan
    Write-Host "1. ตั้งชื่อ: $NEW_REPO_NAME" -ForegroundColor White
    Write-Host "2. อย่าเลือก 'Initialize with README'" -ForegroundColor White
    Write-Host "3. คลิก 'Create repository'" -ForegroundColor White
    Write-Host ""
    Write-Host "เสร็จแล้วกด Enter เพื่อดำเนินการต่อ..." -ForegroundColor Green
    pause

    # เปลี่ยน remote
    Write-Host ""
    Write-Host "Step 3/4: กำลังเปลี่ยน remote..." -ForegroundColor Yellow
    git remote remove origin
    git remote add origin "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME.git"

    Write-Host "[OK] Remote ใหม่:" -ForegroundColor Green
    git remote -v
    Write-Host ""

    # Push
    Write-Host "Step 4/4: กำลัง Push ไปที่ GitHub..." -ForegroundColor Yellow
    Write-Host "(จะต้องกรอก username/password หรือ token)" -ForegroundColor Gray
    Write-Host ""

    git push -u origin main

    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host " สำเร็จ! Push พร้อม Commit History แล้ว" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Repository URL:" -ForegroundColor Yellow
        Write-Host "https://github.com/$YOUR_USERNAME/$NEW_REPO_NAME" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "ตรวจสอบ Commit History:" -ForegroundColor Yellow
        git log --oneline --graph --all
    } else {
        Write-Host ""
        Write-Host "[ERROR] Push ไม่สำเร็จ!" -ForegroundColor Red
        Write-Host ""
        Write-Host "วิธีแก้:" -ForegroundColor Yellow
        Write-Host "1. ตรวจสอบว่าสร้าง repository บน GitHub แล้ว" -ForegroundColor White
        Write-Host "2. ลองใช้ Personal Access Token แทน password" -ForegroundColor White
        Write-Host "   สร้างที่: https://github.com/settings/tokens" -ForegroundColor Cyan
        Write-Host "3. หรือลอง Force push:" -ForegroundColor White
        Write-Host "   git push -u origin main --force" -ForegroundColor Gray
    }

} else {
    Write-Host "[ERROR] กรุณาเลือก 1 หรือ 2 เท่านั้น!" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
pause
