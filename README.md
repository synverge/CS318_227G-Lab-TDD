# Hello TDD - Test-Driven Development Lab

โปรเจค TDD สำหรับเรียนรู้การพัฒนาซอฟต์แวร์แบบ Test-Driven Development

## โครงสร้างโปรเจค

```
hello-tdd/
├── src/
│   ├── main/java/com/example/
│   │   └── Greeting.java          # คลาสหลักที่ทำงาน
│   └── test/java/com/example/
│       └── GreetingTest.java      # Test cases
├── pom.xml                         # Maven configuration
├── install-windows.bat             # สคริปต์ติดตั้ง (Windows)
├── run-tests.bat                   # สคริปต์รัน tests (Windows)
└── README.md                       # ไฟล์นี้
```

## การติดตั้งบน Windows

**สำหรับคำสั่ง CLI ทั้งหมด ดูที่ → [WINDOWS-CLI.md](WINDOWS-CLI.md)**

### วิธีที่ 1: ใช้ PowerShell CLI (แนะนำ - เร็วที่สุด)

```powershell
# เปิด PowerShell แบบ Admin (Win + X → "Terminal (Admin)")
cd C:\path\to\hello-tdd
.\install.ps1
```

### วิธีที่ 2: ใช้สคริปต์อัตโนมัติ

1. **คลิกขวาที่ไฟล์ `install-windows.bat`**
2. **เลือก "Run as administrator"** (สำคัญมาก!)
3. รอให้ติดตั้ง Java และ Maven เสร็จ
4. **ปิดหน้าต่าง Command Prompt**
5. **เปิด Command Prompt ใหม่** (เพื่อให้ตัวแปรสภาพแวดล้อมอัพเดท)

### วิธีที่ 3: ติดตั้งด้วยตัวเอง

#### 2.1 ติดตั้ง Java

1. ดาวน์โหลด Java JDK 11 จาก:
   - https://adoptium.net/ (แนะนำ)
   - หรือ https://www.oracle.com/java/technologies/downloads/

2. รันไฟล์ติดตั้งและทำตามขั้นตอน

3. ตรวจสอบการติดตั้ง:
   ```cmd
   java -version
   ```

#### 2.2 ติดตั้ง Maven

1. ดาวน์โหลด Maven จาก:
   - https://maven.apache.org/download.cgi

2. แตกไฟล์ไปที่ `C:\Program Files\Apache\maven`

3. เพิ่ม Maven เข้า PATH:
   - กด `Windows + R` พิมพ์ `sysdm.cpl`
   - ไปที่แท็บ `Advanced` > `Environment Variables`
   - ในส่วน `System variables` เลือก `Path` > `Edit`
   - เพิ่ม `C:\Program Files\Apache\maven\bin`

4. ตรวจสอบการติดตั้ง:
   ```cmd
   mvn -version
   ```

## การรัน Tests

### วิธีที่ 1: ใช้ CLI (แนะนำ)

```bash
cd hello-tdd
mvn test
```

### วิธีที่ 2: ใช้สคริปต์ (ง่ายที่สุด)

ดับเบิลคลิกที่ไฟล์ **`run-tests.bat`**

### วิธีที่ 3: รัน test เฉพาะ

```cmd
# รัน test class เดียว
mvn test -Dtest=GreetingTest

# รัน test method เดียว
mvn test -Dtest=GreetingTest#testHelloBasic
```

## คำอธิบายโค้ด

### Greeting.java

```java
public String sayHello(String name) {
    if (name == null) {
        return "Hello, Friend";
    }
    return "Hello, " + name;
}
```

เมธอดนี้:
- รับชื่อเป็น parameter
- ถ้า name เป็น `null` จะคืนค่า "Hello, Friend"
- ถ้าไม่เป็น null จะคืนค่า "Hello, " + ชื่อ

### GreetingTest.java

มี 2 test cases:

1. **testHelloBasic** - ทดสอบกรณีปกติ
   ```java
   assertEquals("Hello, World", greeting.sayHello("World"));
   ```

2. **testHelloNull** - ทดสอบกรณี input เป็น null
   ```java
   assertEquals("Hello, Friend", greeting.sayHello(null));
   ```

## TDD Cycle ที่ใช้ในโปรเจคนี้

1. **RED** - เขียน test ที่ fail ก่อน
2. **GREEN** - เขียนโค้ดให้ test ผ่าน
3. **REFACTOR** - ปรับปรุงโค้ดให้ดีขึ้น

## การแก้ปัญหาที่พบบ่อย

### ปัญหา: `'java' is not recognized`

**วิธีแก้:**
1. ตรวจสอบว่าติดตั้ง Java แล้ว
2. เพิ่ม Java เข้า PATH environment variable
3. ปิดและเปิด Command Prompt ใหม่

### ปัญหา: `'mvn' is not recognized`

**วิธีแก้:**
1. ตรวจสอบว่าติดตั้ง Maven แล้ว
2. เพิ่ม Maven เข้า PATH environment variable
3. ปิดและเปิด Command Prompt ใหม่

### ปัญหา: Test ไม่ผ่าน

**วิธีแก้:**
1. อ่าน error message ที่แสดง
2. ตรวจสอบว่าโค้ดใน `Greeting.java` ถูกต้องหรือไม่
3. ตรวจสอบว่า test ใน `GreetingTest.java` ถูกต้องหรือไม่

## คำสั่ง Maven ที่มีประโยชน์

```cmd
# คอมไพล์โค้ด
mvn compile

# รัน tests
mvn test

# ล้าง build artifacts
mvn clean

# คอมไพล์และรัน tests
mvn clean test

# สร้าง JAR file
mvn package

# ดูข้อมูล dependencies
mvn dependency:tree
```

## เพิ่ม Test Cases เพิ่มเติม

ลองเพิ่ม test cases เหล่านี้ดูครับ:

```java
@Test
void testHelloEmptyString() {
    Greeting greeting = new Greeting();
    String result = greeting.sayHello("");
    assertEquals("Hello, Friend", result);
}

@Test
void testHelloWithMultipleNames() {
    Greeting greeting = new Greeting();
    String result = greeting.sayHello("Alice");
    assertEquals("Hello, Alice", result);
}
```

## License

MIT License - ใช้เพื่อการศึกษาได้ตามต้องการ
