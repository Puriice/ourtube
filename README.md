# OurTube

แอปดูและอัปโหลดวิดีโอ สร้างด้วย Flutter (โปรเจกต์รายวิชา CP213)
เก็บข้อมูลทั้งหมดไว้ในเครื่องด้วย SQLite ไม่ต้องใช้เซิร์ฟเวอร์

## ภาพการใช้งาน

| หน้าแรก | เล่นวิดีโอ | กรองตามหมวดหมู่ |
| :---: | :---: | :---: |
| <img src="docs/screenshots/01_home.png" width="250"> | <img src="docs/screenshots/02_play.png" width="250"> | <img src="docs/screenshots/03_category.png" width="250"> |
| รายการวิดีโอเรียงจากใหม่ไปเก่า พร้อมชื่อช่อง ยอดวิว และเวลาที่อัปโหลด | กดที่วิดีโอเพื่อเปิดหน้าเล่น ดูรายละเอียดและปุ่ม Like / Share / Download | กดแท็บ All, Music, News, Animal ฯลฯ เพื่อกรองวิดีโอ |

| ค้นหา | อัปโหลดวิดีโอ | โปรไฟล์ |
| :---: | :---: | :---: |
| <img src="docs/screenshots/04_search.png" width="250"> | <img src="docs/screenshots/05_upload.png" width="250"> | <img src="docs/screenshots/06_profile.png" width="250"> |
| กดไอคอนแว่นขยาย พิมพ์คำค้นแล้วกด Enter | กดปุ่ม ⊕ ตรงกลางแถบล่าง วางลิงก์ YouTube หรือเลือกไฟล์จากเครื่อง | กดแท็บ Profile ดูวิดีโอที่เราอัปโหลด เปลี่ยนชื่อและรูปโปรไฟล์ |

| ตั้งค่า | Dark mode |
| :---: | :---: |
| <img src="docs/screenshots/07_settings.png" width="250"> | <img src="docs/screenshots/08_dark.png" width="250"> |
| กดไอคอนเฟืองมุมขวาบน | เปิด Dark mode ได้จากหน้าตั้งค่า |

## ฟีเจอร์

**ดูวิดีโอ**
- แสดงรายการวิดีโอพร้อมภาพปก ความยาว ยอดวิว (เช่น 28M) และเวลาที่ผ่านมา (เช่น 7 years ago)
- เล่นวิดีโอ YouTube ด้วย `youtube_player_flutter` และวิดีโอจากเครื่องด้วย `video_player`
- วิดีโอที่มาจากลิงก์ YouTube มีป้าย **▶ YouTube** สีแดงบนการ์ดและหน้าเล่น
- กรองวิดีโอตามหมวดหมู่ และค้นหาจากชื่อวิดีโอ

**อัปโหลดวิดีโอ**
- **YouTube link:** วางลิงก์ (หรือ ID 11 ตัว) แอปดึงภาพปกให้อัตโนมัติ
- **From phone:** เลือกวิดีโอจากแกลเลอรี แอปอ่านความยาวให้อัตโนมัติ และคัดลอกไฟล์ไปเก็บในโฟลเดอร์ของแอป
- วิดีโอที่อัปโหลดเป็นของโปรไฟล์เราเอง ไม่ต้องเลือกช่อง

**โปรไฟล์**
- เปลี่ยนชื่อ (กดดินสอ) และรูปโปรไฟล์ (แตะที่รูป)
- ดูรายการวิดีโอที่เราอัปโหลด กดค้างที่วิดีโอเพื่อลบ

**ตั้งค่า**
- **Dark mode:** เปิด/ปิดธีมมืด
- **Autoplay:** เล่นวิดีโอทันทีเมื่อเปิด
- **Delete all videos:** ลบวิดีโอทั้งหมด (ทั้งข้อมูลใน database และไฟล์ที่คัดลอกไว้)
- ค่าที่ตั้งถูกจำไว้ด้วย `shared_preferences` แม้ปิดแอปแล้วเปิดใหม่

## สิ่งที่ต้องมี

- Flutter 3.47 ขึ้นไป (Dart 3.13+)
- Android SDK + JDK 17 ขึ้นไป (ใช้ JDK ที่มากับ Android Studio ได้)
- Android Gradle Plugin 8.11 / Gradle 8.14 (ตั้งค่าไว้ในโปรเจกต์แล้ว)

## วิธีรัน

```bash
git clone https://github.com/Puriice/ourtube.git
cd ourtube
flutter pub get
flutter run
```

เปิดแอปครั้งแรก database ยังว่าง หน้าแรกจะขึ้นว่า *No videos yet* ให้กดปุ่ม ⊕ แล้วอัปโหลดวิดีโอก่อน

> **หมายเหตุ:** ถ้าเปิดโปรเจกต์ใน VS Code แล้วมีส่วนขยาย Java/Gradle ติดตั้งอยู่ ส่วนขยายอาจแก้ไฟล์
> `android/gradle/wrapper/gradle-wrapper.properties` เป็น Gradle 9.x ซึ่งใช้กับ AGP 8 ไม่ได้
> ถ้า build ไม่ผ่าน ให้ตรวจว่า `distributionUrl` ยังเป็น `gradle-8.14.3-all.zip`

## โครงสร้างโปรเจกต์

```
lib/
├── main.dart                 # จุดเริ่มต้นของแอป ธีม และ provider
├── screens/                  # หน้าจอ: home, video_play, search, add_video, profile, settings
├── components/               # วิดเจ็ตย่อย: card, top_bar, nav_bar, user_avatar, youtube_tag, ตัวจัดรูปแบบตัวเลข/เวลา
├── model/                    # โมเดล Video, User
├── providers/                # state: หมวดหมู่ที่เลือก, รายการวิดีโอ/โปรไฟล์, ค่า settings
└── database/                 # การเชื่อมต่อ SQLite และ service สำหรับวิดีโอและโปรไฟล์
```

**Database (SQLite)** มี 2 ตาราง:
- `Video` เก็บข้อมูลวิดีโอ คอลัมน์ `source` บอกว่ามาจาก `youtube` หรือ `local` และ `localPath` เก็บที่อยู่ไฟล์ของวิดีโอจากเครื่อง
- `Profile` เก็บชื่อและรูปโปรไฟล์ของเรา
