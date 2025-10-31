# Windows CLI Commands - TDD Lab

## วิธีติดตั้งแบบ CLI (Command Line)

### วิธีที่ 1: ใช้ PowerShell (แนะนำ)

1. **เปิด PowerShell แบบ Administrator:**
   - กด `Win + X`
   - เลือก "Windows PowerShell (Admin)" หรือ "Terminal (Admin)"

2. **ไปที่โฟลเดอร์โปรเจค:**
   ```powershell
   cd C:\path\to\hello-tdd
   ```

3. **รันสคริปต์ติดตั้ง:**
   ```powershell
   .\install.ps1
   ```

   หากเจอ error เรื่อง execution policy ให้รันคำสั่งนี้ก่อน:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

4. **ปิด PowerShell และเปิดใหม่**

5. **ตรวจสอบการติดตั้ง:**
   ```powershell
   java -version
   mvn -version
   ```

### วิธีที่ 2: ใช้ Command Prompt

1. **เปิด Command Prompt แบบ Administrator:**
   - กด `Win + R`
   - พิมพ์ `cmd`
   - กด `Ctrl + Shift + Enter`

2. **ไปที่โฟลเดอร์โปรเจค:**
   ```cmd
   cd C:\path\to\hello-tdd
   ```

3. **รันสคริปต์ติดตั้ง:**
   ```cmd
   install-windows.bat
   ```

4. **ปิด Command Prompt และเปิดใหม่**

---

## คำสั่ง CLI สำหรับรัน Tests

### รัน Tests ทั้งหมด

```bash
cd hello-tdd
mvn test
```

### รัน Test เฉพาะ Class

```bash
mvn test -Dtest=GreetingTest
```

### รัน Test เฉพาะ Method

```bash
# รัน testHelloBasic เท่านั้น
mvn test -Dtest=GreetingTest#testHelloBasic

# รัน testHelloNull เท่านั้น
mvn test -Dtest=GreetingTest#testHelloNull
```

### คอมไพล์โค้ด (ไม่รัน test)

```bash
mvn compile
```

### ล้างไฟล์ build แล้วรัน test ใหม่

```bash
mvn clean test
```

### รัน test และดู output แบบละเอียด

```bash
mvn test -X
```

### สร้าง JAR file

```bash
mvn package
```

---

## คำสั่ง One-Liner (คัดลอกไปวางได้เลย)

### ติดตั้งทุกอย่างด้วย PowerShell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')); choco install openjdk11 maven -y
```

### ติดตั้งและรัน test ทันที

```powershell
# PowerShell
cd C:\path\to\hello-tdd; .\install.ps1; mvn test
```

```cmd
REM Command Prompt
cd C:\path\to\hello-tdd && install-windows.bat && mvn test
```

---

## ตัวอย่างผลลัพธ์ที่ควรเห็น

### เมื่อรัน `mvn test` สำเร็จ:

```
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running com.example.GreetingTest
[INFO] Tests run: 2, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.123 s
[INFO]
[INFO] Results:
[INFO]
[INFO] Tests run: 2, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

### เมื่อ test fail:

```
[ERROR] Tests run: 2, Failures: 1, Errors: 0, Skipped: 0
[ERROR] testHelloNull(com.example.GreetingTest)  Time elapsed: 0.012 s  <<< FAILURE!
org.opentest4j.AssertionFailedError: expected: <Hello, Friend> but was: <Hello, null>
```

---

## การแก้ปัญหา CLI

### ปัญหา: `'java' is not recognized`

```bash
# ตรวจสอบ PATH
echo %PATH%

# เพิ่ม Java เข้า PATH (ชั่วคราว)
set PATH=%PATH%;C:\Program Files\OpenJDK\jdk-11\bin

# เพิ่ม Java เข้า PATH (ถาวร) - PowerShell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\OpenJDK\jdk-11\bin", "Machine")
```

### ปัญหา: `'mvn' is not recognized`

```bash
# ตรวจสอบว่าติดตั้ง Maven ที่ไหน
where mvn

# เพิ่ม Maven เข้า PATH (ชั่วคราว)
set PATH=%PATH%;C:\ProgramData\chocolatey\lib\maven\apache-maven-3.9.5\bin

# เพิ่ม Maven เข้า PATH (ถาวร) - PowerShell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\ProgramData\chocolatey\lib\maven\apache-maven-3.9.5\bin", "Machine")
```

### ปัญหา: PowerShell execution policy

```powershell
# ดู policy ปัจจุบัน
Get-ExecutionPolicy

# เปลี่ยน policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## คำสั่งที่มีประโยชน์เพิ่มเติม

### ดูข้อมูล Dependencies

```bash
mvn dependency:tree
```

### ดาวน์โหลด Dependencies ทั้งหมด

```bash
mvn dependency:resolve
```

### ล้าง cache ของ Maven

```bash
mvn dependency:purge-local-repository
```

### ตรวจสอบ code style

```bash
mvn checkstyle:check
```

### รัน test แบบ parallel (เร็วขึ้น)

```bash
mvn test -T 4
```

### Skip tests (เมื่อต้องการ build เร็วๆ)

```bash
mvn package -DskipTests
```

---

## Quick Reference

| คำสั่ง | คำอธิบาย |
|--------|---------|
| `mvn test` | รัน tests ทั้งหมด |
| `mvn clean test` | ล้างแล้วรัน tests |
| `mvn compile` | คอมไพล์เท่านั้น |
| `mvn package` | สร้าง JAR file |
| `mvn clean` | ลบไฟล์ build |
| `mvn -version` | ดูเวอร์ชั่น Maven |
| `java -version` | ดูเวอร์ชั่น Java |

---

## ทดสอบแบบ Interactive

หากต้องการทดสอบโดยไม่ผ่าน Maven ให้ใช้ `jshell` (Java REPL):

```bash
# เปิด jshell
jshell

# โหลด class
/open src/main/java/com/example/Greeting.java

# ทดสอบ
Greeting g = new Greeting()
g.sayHello("World")
g.sayHello(null)

# ออกจาก jshell
/exit
```
