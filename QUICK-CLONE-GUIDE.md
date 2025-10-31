# คู่มือด่วน: โหลดโค้ดพร้อม Commit History

## สำหรับเพื่อนที่จะโหลดโค้ดของคุณ

### วิธีที่ 1: Fork บน GitHub (แนะนำ - 2 นาทีเสร็จ)

1. **ไปที่:** https://github.com/synverge/CS318_227G-Lab-TDD

2. **คลิก "Fork"** ที่มุมขวาบน

3. **เลือก account ของตัวเอง**

4. **เสร็จแล้ว!** ตอนนี้คุณมี repo ของตัวเองพร้อม commit history ทั้งหมด

5. **Clone ลงเครื่อง:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/CS318_227G-Lab-TDD.git
   cd CS318_227G-Lab-TDD
   git log --oneline
   ```

---

### วิธีที่ 2: Clone แล้วสร้าง Repo ใหม่ (5 นาที)

```bash
# 1. Clone ต้นฉบับ
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git my-lab
cd my-lab

# 2. ไปสร้าง repo ใหม่บน GitHub (https://github.com/new)
#    ตั้งชื่อ: my-lab
#    อย่าติ๊ก "Initialize with README"

# 3. เปลี่ยน remote
git remote remove origin
git remote add origin https://github.com/YOUR-USERNAME/my-lab.git

# 4. Push (เก็บ history ทั้งหมด)
git push -u origin main

# 5. ตรวจสอบ
git log --oneline
```

---

## ตรวจสอบว่ามี Commit History

```bash
git log --oneline --graph
```

**ควรเห็น:**
```
* 79c5509 [GREEN] Update sayHello to handle null case
* aae2175 [RED] Add failing test for testHelloNull (null case)
* 21877af [GREEN] Implement sayHello to pass testHelloBasic
* cb11d2c [RED] Add failing test for testHelloBasic
* d1f2a06 Initial: Setup Maven project and add JUnit 5
```

---

## One-Liner: Clone และเปลี่ยน Remote

```bash
git clone https://github.com/synverge/CS318_227G-Lab-TDD.git my-lab && cd my-lab && git remote remove origin && echo "Now run: git remote add origin YOUR_NEW_REPO_URL && git push -u origin main"
```

---

## สำหรับอาจารย์: ตรวจ Commit History

เข้าไปที่ URL ของนักศึกษา แล้วคลิก:
1. **"Commits"** - เพื่อดู commit history
2. **"Network"** - เพื่อดู graph
3. คลิกแต่ละ commit เพื่อดูการเปลี่ยนแปลง

---

## วิธีแก้ปัญหา

### ปัญหา: Push ขึ้น "rejected"

```bash
# Force push (ถ้าแน่ใจว่าไม่มีข้อมูลสำคัญบน GitHub)
git push -u origin main --force
```

### ปัญหา: ไม่เห็น Commit History

```bash
# ตรวจสอบว่า clone ถูกต้อง
git log --oneline

# ถ้าไม่มี ให้ clone ใหม่
git clone --no-single-branch https://github.com/synverge/CS318_227G-Lab-TDD.git
```

---

## สรุป

✅ **Fork** = ง่ายที่สุด (คลิกเดียวบน GitHub)
✅ **Clone + Push** = ยืดหยุ่นกว่า (เปลี่ยนชื่อ repo ได้)
✅ **ทั้ง 2 วิธีเก็บ commit history ครบ**
