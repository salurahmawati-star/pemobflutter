# Penjelasan Praktikum Pertemuan 6
## Tema, Routing dan Navigasi, serta Animasi

---

# 1. Tujuan Praktikum

Praktikum Pertemuan 6 bertujuan untuk memahami penerapan tema pada aplikasi Flutter, termasuk mode terang dan gelap serta perubahan warna tema. Praktikum juga bertujuan memahami penggunaan named routes, pengiriman argumen antarhalaman, Hero transition, NavigationBar, dan IndexedStack. Selain itu, praktikum mempelajari penggunaan animasi implicit seperti AnimatedContainer dan AnimatedSwitcher, serta animasi explicit menggunakan AnimationController.

---

# 2. Dasar Teori

Flutter menyediakan ThemeData untuk mengatur tampilan dan gaya aplikasi secara terpusat. Dengan ThemeData, aplikasi dapat menggunakan tema terang dan gelap serta menentukan warna utama menggunakan colorSchemeSeed. Widget dapat mengambil warna dan gaya dari Theme.of(context) sehingga tampilan aplikasi menjadi lebih konsisten.

Flutter juga menyediakan sistem navigasi menggunakan named routes. Navigasi dapat dilakukan menggunakan Navigator.pushNamed() dengan mengirimkan argumen ke halaman tujuan. Selain itu, Hero dapat digunakan untuk memberikan efek perpindahan visual pada widget yang memiliki tag yang sama di halaman asal dan tujuan.

Dalam pembuatan animasi, Flutter menyediakan animasi implicit seperti AnimatedContainer dan AnimatedSwitcher yang secara otomatis melakukan transisi ketika nilai berubah. Untuk animasi explicit, digunakan AnimationController yang memberikan kontrol lebih besar terhadap jalannya animasi.

---

# 3. Pembahasan Praktikum

## A. Tema dan Pengaturan Warna

Pada bagian A dibuat sistem tema yang dapat digunakan untuk mengubah aplikasi antara mode terang dan gelap. Selain itu, pengguna dapat memilih beberapa warna tema yang tersedia. Pengaturan tema menggunakan ThemeData, ThemeMode, ValueNotifier, dan ListenableBuilder.

Dengan menggunakan Theme.of(context), widget dalam aplikasi dapat mengikuti warna dan gaya tema yang sedang aktif tanpa harus menentukan warna secara manual pada setiap widget.

### Untuk Laporan

Pada bagian A dibuat fitur tema aplikasi yang mendukung mode terang dan gelap serta beberapa pilihan warna tema. Pengaturan menggunakan ThemeData, ThemeMode, dan ValueNotifier sehingga perubahan tema dapat langsung diterapkan pada seluruh aplikasi. Widget menggunakan Theme.of(context) untuk mengambil warna dan gaya dari tema yang sedang aktif sehingga tampilan aplikasi menjadi lebih konsisten.

---

## B. Named Routes dan Hero

Pada bagian B dibuat halaman beranda yang menampilkan beberapa item. Ketika salah satu item dipilih, aplikasi berpindah ke halaman detail menggunakan named route `/detail`. Data item dikirim menggunakan arguments.

Pada halaman detail digunakan Hero dengan tag yang sama seperti pada halaman sebelumnya sehingga icon item dapat memiliki efek perpindahan animasi ketika halaman dibuka.

### Untuk Laporan

Pada bagian B diterapkan named routes untuk melakukan navigasi dari halaman beranda menuju halaman detail. Data item dikirim menggunakan arguments melalui Navigator.pushNamed(), kemudian diterima pada onGenerateRoute. Halaman detail juga menggunakan Hero dengan tag yang sama sehingga perpindahan icon dari halaman beranda ke halaman detail dapat ditampilkan dengan animasi transisi.

---

## C. Animasi

Pada bagian C dibuat tiga contoh animasi. AnimatedContainer digunakan untuk mengubah ukuran, warna, dan bentuk container secara otomatis. AnimatedSwitcher digunakan untuk memberikan animasi ketika nilai angka berubah.

Selanjutnya AnimationController digunakan bersama RotationTransition untuk membuat animasi rotasi yang dapat dikontrol secara manual. Controller dapat dihentikan dan dijalankan kembali menggunakan tombol.

### Untuk Laporan

Pada bagian C dibuat beberapa contoh animasi Flutter, yaitu AnimatedContainer, AnimatedSwitcher, dan RotationTransition dengan AnimationController. AnimatedContainer digunakan untuk mengubah ukuran dan tampilan container, sedangkan AnimatedSwitcher digunakan untuk memberikan efek perpindahan ketika nilai berubah. AnimationController digunakan untuk mengontrol animasi rotasi sehingga pengguna dapat menghentikan dan menjalankan kembali animasi.

---

## D. NavigationBar dan IndexedStack

Pada bagian D dibuat ShellPage yang menjadi halaman utama aplikasi dan memiliki tiga tab, yaitu Beranda, Animasi, dan Pengaturan.

Perpindahan tab dilakukan menggunakan NavigationBar, sedangkan IndexedStack digunakan untuk menampilkan halaman berdasarkan index yang dipilih. Dengan struktur tersebut, seluruh fitur dari bagian sebelumnya dapat digabungkan menjadi satu aplikasi.

### Untuk Laporan

Pada bagian D dibuat navigasi utama menggunakan NavigationBar yang terdiri dari tiga tab yaitu Beranda, Animasi, dan Pengaturan. IndexedStack digunakan untuk menampilkan halaman berdasarkan tab yang dipilih. Dengan menggabungkan bagian A, B, dan C ke dalam ShellPage, aplikasi memiliki struktur navigasi yang lebih terorganisasi dan seluruh fitur dapat digunakan dalam satu aplikasi.

---

# 4. Latihan Mandiri

Latihan mandiri dilakukan pada file `main.dart` yang sama dengan pengembangan sebelumnya. Terdapat lima pengembangan, yaitu penyimpanan pengaturan tema menggunakan shared_preferences, penambahan Drawer, penggunaan FadeTransition, penanganan route yang tidak ditemukan menggunakan onUnknownRoute, dan penambahan animasi AnimatedOpacity.

## 4.1 Penyimpanan Tema

Pengaturan mode gelap dan warna tema disimpan menggunakan shared_preferences sehingga pengaturan dapat dimuat kembali ketika aplikasi dijalankan.

## 4.2 Drawer

Drawer ditambahkan pada ShellPage sebagai menu tambahan untuk berpindah antara tab Beranda, Animasi, dan Pengaturan.

## 4.3 FadeTransition

Transisi menuju halaman detail dikembangkan menggunakan PageRouteBuilder dan FadeTransition sehingga halaman detail dapat muncul dengan efek fade.

## 4.4 onUnknownRoute

onUnknownRoute digunakan untuk menangani route yang tidak tersedia dengan menampilkan halaman "404 - Halaman tidak ditemukan".

## 4.5 AnimatedOpacity

AnimatedOpacity ditambahkan pada AnimasiTab sebagai animasi tambahan yang membuat sebuah kartu dapat memudar dan muncul kembali ketika tombol ditekan.

### Untuk Laporan

Pada latihan mandiri dilakukan pengembangan aplikasi dalam satu file `main.dart` dengan menambahkan beberapa fitur. Pengaturan mode gelap dan warna tema disimpan menggunakan shared_preferences, kemudian ditambahkan Drawer sebagai menu navigasi alternatif. Transisi halaman detail dikembangkan menggunakan PageRouteBuilder dan FadeTransition, sedangkan onUnknownRoute digunakan untuk menampilkan halaman 404 ketika route tidak ditemukan. Selain itu, ditambahkan AnimatedOpacity sebagai contoh animasi tambahan untuk membuat sebuah kartu dapat memudar dan muncul kembali.

---

# 5. Tugas – Galeri/Katalog Interaktif

## Tujuan Tugas

Pada tugas ini dibuat sebuah aplikasi Galeri/Katalog Interaktif menggunakan Flutter. Aplikasi menggabungkan materi tema, routing, navigasi, dan animasi yang telah dipelajari pada Pertemuan 6.

Aplikasi dibuat dengan minimal tiga tab menggunakan NavigationBar, memiliki halaman detail dengan named routes dan arguments, serta menggunakan Hero untuk memberikan efek transisi pada objek yang dipilih.

## Ketentuan Tugas

Aplikasi yang dibuat memiliki beberapa ketentuan utama:

1. Minimal 3 tab menggunakan NavigationBar.
2. Named routes dengan arguments untuk membuka halaman detail.
3. Halaman detail menggunakan Hero.
4. Memiliki minimal dua jenis animasi:
    - satu animasi implicit;
    - satu animasi explicit menggunakan AnimationController.
5. Memiliki mode terang dan gelap.
6. Memiliki minimal 3 pilihan warna tema.
7. Pengaturan tema tersimpan setelah aplikasi ditutup.
8. Warna dan gaya teks menggunakan Theme.of(context).
9. Menghindari penggunaan warna hard-coded pada teks dan latar aplikasi.
10. Mengumpulkan screenshot mode terang, mode gelap, halaman detail, serta kode atau tautan repository.

## Implementasi Tugas

Pada tugas ini aplikasi dibuat dalam satu file `main.dart` dengan menggabungkan konsep yang telah dipelajari sebelumnya.

### 5.1 Tab Beranda

Tab Beranda digunakan untuk menampilkan daftar item katalog. Setiap item dapat dipilih oleh pengguna untuk membuka halaman detail.

Ketika item ditekan, navigasi dilakukan menggunakan named route dengan mengirimkan data item sebagai arguments.

Alur navigasi:

Beranda  
↓  
Pilih item  
↓  
Named Route  
↓  
Halaman Detail

Halaman detail menggunakan Hero sehingga objek yang dipilih dapat memiliki efek transisi dari halaman Beranda menuju halaman Detail.

### 5.2 Tab Animasi

Tab Animasi digunakan untuk menampilkan beberapa contoh animasi Flutter.

Animasi yang digunakan terdiri dari:

- AnimatedContainer sebagai animasi implicit.
- AnimatedSwitcher sebagai animasi implicit tambahan.
- RotationTransition dengan AnimationController sebagai animasi explicit.
- AnimatedOpacity sebagai pengembangan dari latihan mandiri.

Dengan demikian, aplikasi memenuhi ketentuan tugas mengenai penggunaan minimal dua jenis animasi.

### 5.3 Tab Pengaturan

Tab Pengaturan digunakan untuk mengubah tampilan aplikasi.

Pengguna dapat memilih:

- Mode terang
- Mode gelap
- Beberapa pilihan warna tema

Pengaturan tema kemudian disimpan menggunakan shared_preferences sehingga ketika aplikasi ditutup dan dibuka kembali, pengaturan sebelumnya dapat digunakan kembali.

### 5.4 Penggunaan Theme.of(context)

Dalam aplikasi, warna dan gaya tampilan mengambil nilai dari tema yang telah dibuat. Widget tidak memberikan warna hard-coded secara langsung pada teks dan latar, tetapi menggunakan tema aplikasi.

Contohnya:

```dart
Theme.of(context).colorScheme.primary