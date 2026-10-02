# Penjelasan Modul Praktikum Flutter Fundamental
## Pertemuan 1: Pengenalan Flutter, Instalasi, dan Aplikasi Pertama

## 1. Tujuan Pembelajaran

Praktikum ini bertujuan agar mahasiswa mampu:
1. Menjelaskan Flutter dan Dart serta perbedaannya dengan pengembangan native.
2. Memasang Flutter SDK, editor, dan emulator atau perangkat fisik.
3. Membuat dan menjalankan proyek Flutter pertama.
4. Memahami struktur folder proyek dan konsep dasar widget.
5. Memodifikasi antarmuka sederhana dan menggunakan Hot Reload.

## 2. Alat dan Bahan

Alat dan bahan yang digunakan dalam praktikum ini meliputi:
- Laptop dengan RAM minimal 8 GB dan ruang disk minimal 10 GB.
- Flutter SDK versi stabil.
- Android Studio atau VS Code dengan ekstensi Flutter dan Dart.
- Emulator Android atau HP Android dengan Developer Mode dan USB Debugging aktif.
- Koneksi internet.

## 3. Teori Singkat

### 3.1 Flutter
Flutter adalah UI toolkit dari Google yang digunakan untuk membangun aplikasi mobile, web, dan desktop menggunakan satu basis kode.

### 3.2 Dart
Dart adalah bahasa pemrograman yang digunakan untuk mengembangkan aplikasi Flutter.

### 3.3 Widget
Widget merupakan elemen penyusun antarmuka Flutter. Teks, tombol, ikon, tata letak, dan bagian aplikasi lainnya dibangun menggunakan widget.

### 3.4 StatelessWidget
StatelessWidget adalah widget yang tidak memiliki state internal yang berubah selama aplikasi berjalan. Widget ini cocok untuk tampilan yang relatif tetap.

### 3.5 StatefulWidget
StatefulWidget adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Perubahan state dapat digunakan untuk memperbarui tampilan aplikasi.

### 3.6 Hot Reload
Hot Reload merupakan fitur Flutter untuk menerapkan perubahan kode dengan cepat tanpa harus memulai ulang seluruh aplikasi.

## 4. Langkah Praktikum

### Bagian A — Instalasi dan Verifikasi

Tahap ini dilakukan untuk memastikan lingkungan pengembangan Flutter telah terpasang dan dikonfigurasi dengan benar.

Perintah yang digunakan:

```bash
flutter doctor
flutter doctor --android-licenses
```

Perintah `flutter doctor` digunakan untuk memeriksa kelengkapan Flutter SDK, Android toolchain, dan editor. Sementara itu, `flutter doctor --android-licenses` digunakan untuk menyetujui lisensi Android SDK yang diperlukan.

**Checkpoint:** Memeriksa status komponen Flutter dan memperbaiki masalah yang ditemukan.

### Bagian B — Membuat Proyek Pertama

Pembuatan proyek dilakukan melalui terminal menggunakan perintah berikut:

```bash
flutter create praktikum_1
cd praktikum_1
flutter run
```

Penjelasan:
- `flutter create praktikum_1` digunakan untuk membuat proyek Flutter baru.
- `cd praktikum_1` digunakan untuk masuk ke direktori proyek.
- `flutter run` digunakan untuk membangun dan menjalankan aplikasi pada emulator atau perangkat yang dipilih.

**Checkpoint:** Aplikasi counter bawaan Flutter berhasil dijalankan dan tombol tambah dapat menaikkan angka.

### Bagian C — Mengenal Struktur Proyek

Struktur utama proyek Flutter terdiri dari beberapa folder dan berkas berikut:

| Folder/Berkas | Fungsi |
|---|---|
| `lib/main.dart` | Titik masuk aplikasi dan tempat kode utama ditulis. |
| `pubspec.yaml` | Mengatur konfigurasi proyek, dependensi, dan aset. |
| `android/` | Menyimpan kode dan konfigurasi khusus Android. |
| `ios/` | Menyimpan kode dan konfigurasi khusus iOS. |
| `test/` | Menyimpan berkas pengujian aplikasi. |

Memahami struktur proyek membantu pengembang mengetahui lokasi kode utama, konfigurasi, dan berkas pengujian.

### Bagian D — Aplikasi Hello Flutter

Pada bagian ini, mahasiswa membuat aplikasi sederhana yang menampilkan teks sapaan pada layar.

Widget yang digunakan:
- `MaterialApp` sebagai kerangka aplikasi.
- `Scaffold` sebagai struktur dasar halaman.
- `AppBar` sebagai bilah judul.
- `Center` untuk menempatkan konten di tengah layar.
- `Text` untuk menampilkan tulisan.

Teks yang ditampilkan adalah `Halo, nama saya [NAMA]!`. Bagian `[NAMA]` diganti dengan nama mahasiswa.

**Checkpoint:** Nama berhasil ditampilkan di tengah halaman aplikasi.

### Bagian E — Widget Layout Dasar

Pada bagian ini, widget `Column` digunakan untuk menyusun ikon, nama, dan NIM secara vertikal.

Widget dan properti yang digunakan:
- `Column`: menyusun widget dari atas ke bawah.
- `MainAxisAlignment.center`: menempatkan elemen di tengah pada sumbu utama.
- `Icon`: menampilkan ikon Flutter.
- `SizedBox`: memberikan jarak antarwidget.
- `Text`: menampilkan nama dan NIM.

**Checkpoint:** Ikon, nama, dan NIM ditampilkan secara vertikal di tengah layar.

### Bagian F — Widget Interaktif (StatefulWidget)

Bagian ini membuat aplikasi Counter yang menampilkan angka dan tombol tambah.

Konsep yang dipelajari:
- `StatefulWidget` digunakan untuk tampilan yang memiliki state yang dapat berubah.
- `_count` merupakan variabel untuk menyimpan angka penghitung.
- `FloatingActionButton` digunakan sebagai tombol aksi.
- `onPressed` menentukan tindakan ketika tombol ditekan.
- `setState()` memberi tahu Flutter bahwa state berubah sehingga tampilan diperbarui.

**Checkpoint:** Angka pada aplikasi bertambah setiap kali tombol tambah ditekan.

## 5. Latihan Mandiri

Latihan mandiri dilakukan dengan memodifikasi aplikasi Counter melalui beberapa langkah berikut:

1. Mengubah warna AppBar dan warna teks.
2. Menambahkan tombol kurang menggunakan ikon `Icons.remove`.
3. Menambahkan tombol reset agar angka kembali ke 0.
4. Mencegah angka menjadi negatif.

Untuk mencegah angka negatif, proses pengurangan dilakukan hanya jika nilai penghitung lebih besar dari 0.

## 6. Tugas — Kartu Perkenalan

Tugas praktikum adalah membuat aplikasi satu halaman bernama **Kartu Perkenalan**.

Aplikasi harus menampilkan:
- Foto atau ikon.
- Nama mahasiswa.
- NIM.
- Jurusan.
- Hobi.

Widget yang digunakan meliputi `Column`, `Text`, `Icon`, dan `SizedBox`.

Hasil yang dikumpulkan berupa tangkapan layar aplikasi yang berjalan dan tautan repositori atau berkas `main.dart`.

## 7. Rubrik Penilaian

| Komponen Penilaian | Bobot |
|---|---:|
| Instalasi berhasil (`flutter doctor`) | 20% |
| Checkpoint Bagian B–F selesai | 40% |
| Latihan mandiri | 20% |
| Tugas Kartu Perkenalan | 20% |

## 8. Pertanyaan Refleksi

### 1. Apa perbedaan StatelessWidget dan StatefulWidget?

StatelessWidget digunakan untuk tampilan yang tidak bergantung pada state internal yang berubah. StatefulWidget memiliki state yang dapat berubah selama aplikasi berjalan sehingga tampilannya dapat diperbarui.

### 2. Mengapa perubahan variabel `_count` perlu dibungkus `setState()`?

`setState()` memberi tahu Flutter bahwa terdapat perubahan data pada state. Dengan demikian, Flutter dapat membangun ulang tampilan agar nilai terbaru ditampilkan pada layar.

### 3. Apa keuntungan Hot Reload dibandingkan rebuild penuh?

Hot Reload memungkinkan perubahan kode ditampilkan dengan cepat tanpa memulai ulang seluruh aplikasi. Fitur ini membantu mempercepat proses pengembangan dan pengujian aplikasi.

## 9. Troubleshooting Umum

| Masalah | Solusi |
|---|---|
| Perintah `flutter` tidak dikenali | Periksa PATH dan buka kembali terminal. |
| Lisensi Android belum diterima | Jalankan `flutter doctor --android-licenses`. |
| Emulator lambat | Periksa apakah virtualisasi VT-x/AMD-V aktif di BIOS. |
| Perangkat tidak terdeteksi | Aktifkan USB Debugging dan periksa menggunakan `flutter devices`. |

## 10. Referensi

- Dokumentasi resmi Flutter: https://docs.flutter.dev
- Dart Language Tour: https://dart.dev/language
- Katalog widget Flutter: https://docs.flutter.dev/ui/widgets