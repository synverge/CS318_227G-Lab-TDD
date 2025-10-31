# วิธีโหลดโค้ดไปใช้งานและเก็บ Commit History

มี 2 วิธีหลักให้เพื่อนหรือคนอื่นโหลดโค้ดของคุณไปใช้พร้อม commit history:

## วิธีที่ 1: Fork (แนะนำ - ง่ายที่สุด)

Fork คือการคัดลอก repository ทั้งหมด (พร้อม commit history) ไปยัง GitHub account ของตัวเอง

### ขั้นตอน Fork:

1. **ไปที่ GitHub Repository ต้นฉบับ:**
   ```
   https://github.com/synverge/CS318_227G-Lab-TDD
   ```

2. **คลิกปุ่ม "Fork" ที่มุมขวาบน**
   - จะมีปุ่ม Fork อยู่ข้างๆ ปุ่ม Star
   - คลิกแล้วเลือก account ของตัวเอง

3. **รอให้ GitHub ทำการ Fork**
   - GitHub จะสร้าง repository ใหม่ใน account ของคุณ
   - URL จะเป็น: `https://github.com/YOUR-USERNAME/CS318_227G-Lab-TDD`

4. **Clone ลงเครื่องของตัวเอง:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/CS318_227G-Lab-TDD.git
   cd CS318_227G-Lab-TDD
   ```

5. **ตรวจสอบ Commit History:**
   ```bash
   git log --oneline --graph --all
   ```

### ผลลัพธ์:
- ✅ มี commit history ทั้งหมดเหมือนต้นฉบับ
- ✅ Repository อยู่ใน GitHub account ของตัวเอง
- ✅ สามารถแก้ไขและ commit เพิ่มเติมได้
- ✅ สามารถ push กลับไปที่ repo ของตัวเองได้

---

## วิธีที่ 2: Clone แล้ว Push ไปที่ Repo ใหม่

วิธีนี้เหมาะกับการสร้าง repository ใหม่ที่มี commit history เดิม

### ขั้นตอน:

#### 1. Clone Repository ต้นฉบับ (พร้อม History)

```bash
# Clone แบบเก็บ history ทั้งหมด
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git
cd CS318_227G-Lab-TDD
```

#### 2. สร้าง Repository ใหม่บน GitHub

- ไปที่ https://github.com/new
- ตั้งชื่อ repository (เช่น `my-tdd-lab`)
- **อย่าเลือก** "Initialize this repository with a README"
- คลิก "Create repository"
- คัดลอก URL ที่ได้ (เช่น `https://github.com/YOUR-USERNAME/my-tdd-lab.git`)

#### 3. เปลี่ยน Remote URL

```bash
# ดู remote ปัจจุบัน
git remote -v

# ลบ origin เดิม
git remote remove origin

# เพิ่ม origin ใหม่ (repo ของตัวเอง)
git remote add origin https://github.com/YOUR-USERNAME/my-tdd-lab.git

# ตรวจสอบอีกครั้ง
git remote -v
```

#### 4. Push ทุกอย่างไปที่ Repo ใหม่

```bash
# Push พร้อม commit history ทั้งหมด
git push -u origin main

# ถ้ามี branch อื่น push ด้วย
git push --all origin

# push tags ด้วย (ถ้ามี)
git push --tags origin
```

#### 5. ตรวจสอบบน GitHub

ไปที่ `https://github.com/YOUR-USERNAME/my-tdd-lab`
- คลิกไปที่ Commits
- จะเห็น commit history ทั้งหมดเหมือนต้นฉบับ

---

## เปรียบเทียบ 2 วิธี

| คุณสมบัติ | Fork | Clone + Push |
|----------|------|--------------|
| ความง่าย | ⭐⭐⭐⭐⭐ (ง่ายมาก) | ⭐⭐⭐ (ปานกลาง) |
| เก็บ History | ✅ ครบ | ✅ ครบ |
| เชื่อมกับต้นฉบับ | ✅ ใช่ (สามารถ sync ได้) | ❌ ไม่เชื่อม |
| เปลี่ยนชื่อ Repo | ❌ เหมือนเดิม (แก้ในหลังได้) | ✅ ตั้งชื่อใหม่ได้เลย |
| ใช้เวลา | น้อย (1-2 นาที) | ปานกลาง (3-5 นาті) |

---

## สำหรับนักศึกษา: วิธีส่งงาน Lab

### วิธีที่ 1: ส่ง URL ของ Fork

```bash
# 1. Fork repo ของอาจารย์
# 2. Clone มาทำงาน
git clone https://github.com/YOUR-USERNAME/CS318_227G-Lab-TDD.git

# 3. ทำ Lab เพิ่มเติม (ถ้ามี)
# ... edit code ...
git add .
git commit -m "Add extra features"

# 4. Push
git push origin main

# 5. ส่ง URL นี้ให้อาจารย์
# https://github.com/YOUR-USERNAME/CS318_227G-Lab-TDD
```

### วิธีที่ 2: Clone แล้วสร้าง Repo ใหม่ของตัวเอง

```bash
# 1. Clone
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git MY-TDD-Lab
cd MY-TDD-Lab

# 2. เปลี่ยน remote
git remote remove origin
git remote add origin https://github.com/YOUR-USERNAME/MY-TDD-Lab.git

# 3. Push (เก็บ commit history ทั้งหมด)
git push -u origin main

# 4. ส่ง URL นี้ให้อาจารย์
# https://github.com/YOUR-USERNAME/MY-TDD-Lab
```

---

## คำสั่งที่มีประโยชน์

### ตรวจสอบ Commit History

```bash
# ดู commits แบบสั้น
git log --oneline

# ดู commits แบบละเอียด
git log

# ดู commits แบบกราฟ
git log --oneline --graph --all

# ดู commits พร้อมไฟล์ที่เปลี่ยน
git log --stat

# ดูว่า commit นี้เปลี่ยนอะไรบ้าง
git show COMMIT_HASH
```

### ตรวจสอบ Remote

```bash
# ดู remote URLs
git remote -v

# ดูรายละเอียด remote
git remote show origin

# เปลี่ยน remote URL
git remote set-url origin NEW_URL
```

### Sync กับ Repo ต้นฉบับ (สำหรับ Fork)

```bash
# เพิ่ม upstream (repo ต้นฉบับ)
git remote add upstream https://github.com/synverge/CS318_227G-Lab-TDD.git

# ดึง commits ใหม่จาก upstream
git fetch upstream

# Merge commits จาก upstream เข้ากับ main
git merge upstream/main

# Push ไปที่ repo ของตัวเอง
git push origin main
```

---

## การแก้ปัญหา

### ปัญหา: Push ไม่ได้ (rejected)

```bash
# ถ้า repo ปลายทางมีไฟล์อยู่แล้ว
git pull origin main --rebase
git push origin main

# หรือ force push (ระวัง: จะลบของเดิมทิ้ง)
git push origin main --force
```

### ปัญหา: ไม่เห็น Commit History

```bash
# ตรวจสอบว่า clone ถูกต้องหรือไม่
git log --oneline

# ถ้าไม่มี commits ให้ clone ใหม่แบบเต็ม
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git
```

### ปัญหา: Authentication Error

```bash
# ใช้ Personal Access Token แทน password
# ไปสร้างที่: https://github.com/settings/tokens
# แล้วใช้ token แทน password ตอน push
```

---

## ตัวอย่าง Script อัตโนมัติ

### สำหรับ Clone และสร้าง Repo ใหม่

สร้างไฟล์ `clone-and-push.sh`:

```bash
#!/bin/bash

# ตั้งค่า
ORIGINAL_REPO="https://github.com/synverge/CS318_227G-Lab-TDD.git"
YOUR_GITHUB_USERNAME="YOUR-USERNAME"
NEW_REPO_NAME="my-tdd-lab"

# Clone
echo "Cloning original repository..."
git clone $ORIGINAL_REPO $NEW_REPO_NAME
cd $NEW_REPO_NAME

# เปลี่ยน remote
echo "Changing remote..."
git remote remove origin
git remote add origin https://github.com/$YOUR_GITHUB_USERNAME/$NEW_REPO_NAME.git

# แสดงสถานะ
echo "Remote changed to:"
git remote -v

echo ""
echo "Now you can push to your new repository:"
echo "  git push -u origin main"
echo ""
echo "Your new repository URL:"
echo "  https://github.com/$YOUR_GITHUB_USERNAME/$NEW_REPO_NAME"
```

วิธีใช้:

```bash
chmod +x clone-and-push.sh
./clone-and-push.sh
```

---

## สรุป

**สำหรับส่งงาน Lab แนะนำ:**
- ใช้วิธี **Fork** (ง่ายและรวดเร็ว)
- Fork แล้ว clone มาทำงานเพิ่มเติม
- Push กลับไปที่ repo ของตัวเอง
- ส่ง URL ให้อาจารย์

**ข้อดี:**
- ✅ เก็บ commit history ครบถ้วน
- ✅ อาจารย์เห็นการทำงานแบบ TDD
- ✅ สามารถ sync กับ repo ต้นฉบับได้
- ✅ ทำได้ง่ายด้วย GUI บน GitHub
