### Template Aplikasi Flutter x Realm
---
Belakangan saya lagi lumayan sering otak atik Realm
Dengan Realm kita bisa membuat fitur realtime mirip dengan yang ada di Firestore.

Kelebihannya dibanding Firebase:
- Realm Flutter by Default menggunakan Model
- Membuat relasi 1 to 1-nya lebih mudah
- Membuat relasi 1 to M-nya lebih mudah
- Memiliki fitur Disconnected Mode
(Artinya, temen2 bisa bikin Aplikasi yang tidak perlu koneksi internet sama sekali)
(Sebuah solusi yang bagus utk membuat Aplikasi Offline)
- Data-nya bisa dibaca sebagai sebuah Stream
(Ga repot lagi dah mau ngerefresh data setelah ada perubahan)
- Cukup nyaman untuk bkin Query2 yang rumit karena adanya RQL
(Realm Query Language)

Nah, kalau kamu mau coba contoh Aplikasi Flutter x Realm-nya
Boleh coba source code aplikasi ini:

#### Task Management dengan Realm
https://github.com/denyocrworld/realm_app_template



### Cara Running Aplikasi
1. Kamu harus menjalankan perintah berikut,
Ketika mengupdate lib/model/model.dart
Agar file model.g.dart di generate!

```
dart pub run realm generate
```

### Konfigurasi
1. Buat AppServices di realm.mongodb.com
2. Masuk ke Rules, setting Default roles and filters ke readAndWriteAll
3. Masuk ke menu AppUsers, masuk ke tab Authentication Providers, aktifkan Email/Password provider.
    - User Confirmation Method, pilih yang Automatically Confirm Users
    - Password Reset method, pilih: Send a password reset email
    - Password Reset URL isi acak dulu saja
4. Klik Save (di bawah), dan klik Review Draft and Deploy(di atas) dan klik Deploy
5. Buat akun baru di menu AppUsers, tambahkan akun ini:

    email: admin@demo.com
    password: 123456

    email: user@demo.com
    password: 123456

6. Masuk ke tab "Device Sync", klik "Start Syncing", klik "No thanks, continue to Sync", Enable Sync, Enable Sync
7. masuk ke tab "Device Sync", ceklis Development Mode,
    - Pilih EXISTING DATABASES
    - Klik OK
8. Klik Review Draft & Deploy (di atas), klik Deploy
9. Buka config.dart, ATUR:
APP_ID
APP_URL

----------

### Elearning Dart & Flutter
#### Price: 149k

Benefit
* Lifetime Membership
* Online Meet di tiap Batch
* Bisa join Batch berikut-nya GRATIS
* Akses E-Learning dengan content lebih dari 60+ jam
* Source Code Full Apps
* Video Slicing UI
* Latihan Coding

Studi Kasus
REALTIME TASK MANAGEMENT APP 
DENGAN FITUR MULTI USER, 
APPROVAL, REALTIME MAP TRACKING, 
REALTIME MAP DIRECTION.

JADWAL
SELASA, KAMIS, JUM`AT
20:00 - Selesai

Payment
A/N Deniansyah
💳 BCA 0953941349
💳 OVO 082146727409
💳 DANA 082146727409
💳 GOPAY 082146727409

Konfirmasi ke
https://wa.me/6282146727409