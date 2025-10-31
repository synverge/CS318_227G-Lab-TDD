# คู่มือใช้งาน PowerShell Scripts สำหรับ Clone Repository

มีสคริปต์ PowerShell 2 ตัวให้เลือกใช้:

---

## 🚀 Script 1: `fork-and-clone.ps1` (แบบมี UI)

สคริปต์แบบโต้ตอบที่มี menu ให้เลือกว่าจะใช้วิธี Fork หรือ Clone+Push

### วิธีใช้:

```powershell
# เปิด PowerShell
# ไปที่โฟลเดอร์ที่มีสคริปต์
cd C:\path\to\hello-tdd

# รันสคริปต์
.\fork-and-clone.ps1
```

### สิ่งที่สคริปต์จะทำ:

1. ถาม GitHub Username ของคุณ
2. ถามว่าต้องการเปลี่ยนชื่อ repo หรือไม่
3. ให้เลือกวิธีการ:
   - **วิธีที่ 1: Fork** - แนบแนวทางการ Fork บน GitHub แล้ว Clone
   - **วิธีที่ 2: Clone + Push** - Clone แล้ว push ไปที่ repo ใหม่
4. ทำตามขั้นตอนอัตโนมัติ
5. แสดง commit history เมื่อเสร็จ

---

## ⚡ Script 2: `clone-to-new-repo.ps1` (แบบเร็ว)

สคริปต์สำหรับ Clone และ Push ไปที่ repository ใหม่แบบตรงไปตรงมา

### วิธีใช้แบบปกติ:

```powershell
# รันสคริปต์แบบธรรมดา
.\clone-to-new-repo.ps1
```

### วิธีใช้แบบระบุ Parameters:

```powershell
# ระบุ username และชื่อ repo
.\clone-to-new-repo.ps1 -Username "your-username" -NewRepoName "my-tdd-lab"
```

### Parameters:

- `-Username` - GitHub username ของคุณ
- `-NewRepoName` - ชื่อ repository ใหม่ (default: `my-tdd-lab`)

### ตัวอย่าง:

```powershell
# ตัวอย่างที่ 1: ระบุแค่ username
.\clone-to-new-repo.ps1 -Username "john-doe"

# ตัวอย่างที่ 2: ระบุทั้ง username และชื่อ repo
.\clone-to-new-repo.ps1 -Username "john-doe" -NewRepoName "cs318-lab"

# ตัวอย่างที่ 3: ไม่ระบุอะไร (จะถามทีหลัง)
.\clone-to-new-repo.ps1
```

---

## 📋 ขั้นตอนการใช้งาน (Clone + Push)

### ก่อนรันสคริปต์:

ไม่ต้องทำอะไรเลย! สคริปต์จะแนะนำให้สร้าง repository บน GitHub ในระหว่างการทำงาน

### ขณะรันสคริปต์:

1. **กรอก GitHub Username** (ถ้าไม่ได้ระบุตอนเรียกสคริปต์)
2. **รอให้ Clone เสร็จ** (ประมาณ 5-10 วินาที)
3. **ไปสร้าง repository บน GitHub** ตามที่สคริปต์บอก:
   - เปิด https://github.com/new
   - ตั้งชื่อตามที่สคริปต์บอก
   - **อย่าติ๊ก** "Initialize with README"
   - คลิก "Create repository"
4. **กลับมากด Enter** ที่หน้าต่าง PowerShell
5. **กรอก credentials** (Username + Personal Access Token)
6. **เสร็จแล้ว!** ตรวจสอบ commit history ได้เลย

---

## 🔐 การ Authentication

GitHub ไม่อนุญาตให้ใช้ password ตรงๆ แล้ว ต้องใช้ **Personal Access Token**

### วิธีสร้าง Personal Access Token:

1. ไปที่: https://github.com/settings/tokens
2. คลิก "Generate new token" → "Generate new token (classic)"
3. ตั้งชื่อ: `TDD Lab Clone` (หรืออะไรก็ได้)
4. เลือก scope: ✅ **repo** (Full control of private repositories)
5. คลิก "Generate token"
6. **คัดลอก token ทันที** (จะไม่เห็นอีก!)
7. ใช้ token นี้แทน password ตอน push

### ตอน Push:

```
Username: your-username
Password: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  ← Personal Access Token
```

---

## 🛠️ การแก้ปัญหา

### ปัญหา: `execution policy`

```powershell
# แก้ไข execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### ปัญหา: `Authentication failed`

**วิธีแก้:**
1. ใช้ Personal Access Token แทน password (ดูขั้นตอนด้านบน)
2. ตรวจสอบว่า token มี scope `repo` หรือไม่

### ปัญหา: `Repository not found`

**วิธีแก้:**
1. ตรวจสอบว่าสร้าง repository บน GitHub แล้ว
2. ตรวจสอบชื่อ repository ให้ตรงกัน
3. ตรวจสอบว่าเป็น public หรือ private (private ต้องมี permission)

### ปัญหา: `! [rejected] main -> main (fetch first)`

**วิธีแก้:**

```powershell
# Force push (ถ้าแน่ใจว่าไม่มีข้อมูลสำคัญบน GitHub)
git push -u origin main --force
```

### ปัญหา: สคริปต์รันไม่ได้

**วิธีแก้:**

```powershell
# ตรวจสอบว่าอยู่ในโฟลเดอร์ที่ถูกต้อง
pwd

# ตรวจสอบว่าไฟล์มีอยู่
ls *.ps1

# รันด้วยการระบุ path เต็ม
powershell -ExecutionPolicy Bypass -File ".\clone-to-new-repo.ps1"
```

---

## 📊 ตรวจสอบผลลัพธ์

### ตรวจสอบ Commit History ในเครื่อง:

```powershell
# ดู commits
git log --oneline --graph --all

# ควรเห็น
# * 45d13cd docs: Add comprehensive guides
# * 79c5509 [GREEN] Update sayHello to handle null case
# * aae2175 [RED] Add failing test for testHelloNull
# * 21877af [GREEN] Implement sayHello to pass testHelloBasic
# * cb11d2c [RED] Add failing test for testHelloBasic
# * d1f2a06 Initial: Setup Maven project and add JUnit 5
```

### ตรวจสอบบน GitHub:

1. ไปที่: `https://github.com/YOUR-USERNAME/YOUR-REPO-NAME`
2. คลิก "**X commits**" (ข้างๆ ปุ่ม Code)
3. จะเห็น commit history ทั้งหมด

---

## 🎯 เปรียบเทียบ 2 Scripts

| คุณสมบัติ | fork-and-clone.ps1 | clone-to-new-repo.ps1 |
|----------|-------------------|---------------------|
| มี UI โต้ตอบ | ✅ ใช่ | ⚠️ น้อย |
| เลือกวิธีการได้ | ✅ Fork หรือ Clone+Push | ❌ Clone+Push อย่างเดียว |
| รองรับ Parameters | ❌ ไม่ | ✅ ใช่ |
| ความเร็ว | ปานกลาง | เร็ว |
| เหมาะกับ | มือใหม่ | คนที่คุ้นเคยแล้ว |

---

## 💡 Tips

### ใช้ Script แบบ One-Liner:

```powershell
# Clone และเปลี่ยน remote แบบเร็ว
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git my-lab; cd my-lab; git remote remove origin; git remote add origin https://github.com/YOUR-USERNAME/my-lab.git
```

### สร้าง Alias สำหรับ Script:

```powershell
# เพิ่มใน PowerShell Profile
Set-Alias clone-tdd "C:\path\to\clone-to-new-repo.ps1"

# จากนั้นใช้ได้แบบนี้
clone-tdd -Username "john-doe"
```

### ทำงานแบบ Batch:

```powershell
# Clone หลาย repos พร้อมกัน
$repos = @("repo1", "repo2", "repo3")
foreach ($repo in $repos) {
    .\clone-to-new-repo.ps1 -Username "john-doe" -NewRepoName $repo
}
```

---

## 📚 ทรัพยากรเพิ่มเติม

- [HOW-TO-CLONE.md](HOW-TO-CLONE.md) - คู่มือละเอียดทั้งหมด
- [QUICK-CLONE-GUIDE.md](QUICK-CLONE-GUIDE.md) - คู่มือสั้นๆ แบบด่วน
- [GitHub Docs: Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [PowerShell Docs](https://docs.microsoft.com/en-us/powershell/)

---

## ✅ Checklist

ก่อนรัน Script ให้แน่ใจว่า:

- [ ] ติดตั้ง Git แล้ว (`git --version`)
- [ ] มี GitHub account
- [ ] มี Personal Access Token (สำหรับ push)
- [ ] เปิด PowerShell ในโฟลเดอร์ที่ถูกต้อง

หลังรัน Script ให้ตรวจสอบ:

- [ ] เห็น commit history ครบ (`git log --oneline`)
- [ ] Repository ขึ้นบน GitHub แล้ว
- [ ] Remote ชื้อไปที่ repo ของตัวเอง (`git remote -v`)

---

**Happy Coding! 🎉**
