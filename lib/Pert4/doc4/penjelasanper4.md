# Penjelasan Praktikum Flutter Pertemuan 4

## 1. Tujuan Pembelajaran

Praktikum Pertemuan 4 membahas pemrograman asinkron pada Dart menggunakan Future, async, dan await. Selain itu, praktikum mempelajari cara mengambil data dari REST API menggunakan paket http dan JSON, membuat class model dengan fromJson, menampilkan data menggunakan FutureBuilder, serta menangani kondisi loading, error, dan kegagalan jaringan.

## 2. Teori Singkat

Pengambilan data dari internet membutuhkan waktu sehingga aplikasi tidak boleh membuat tampilan menjadi tidak responsif. Dart menggunakan Future untuk menyimpan hasil yang akan tersedia kemudian. Kata kunci async digunakan pada fungsi yang menjalankan proses asinkron, sedangkan await digunakan untuk menunggu hasil dari proses tersebut tanpa menghentikan UI. REST API digunakan untuk mengambil atau mengirim data melalui HTTP, sedangkan JSON digunakan sebagai format data. Dalam praktikum ini digunakan JSONPlaceholder sebagai API publik. FutureBuilder digunakan untuk membangun tampilan berdasarkan kondisi Future, seperti sedang memuat, terjadi error, atau data berhasil diperoleh.

## 3. Bagian A — Mengenal Future dan FutureBuilder

Pada bagian A dibuat fungsi ambilSalam() untuk mensimulasikan pengambilan data yang membutuhkan waktu dua detik. Fungsi tersebut menggunakan Future, async, await, dan Future.delayed(). Hasil proses ditampilkan menggunakan FutureBuilder. Ketika proses masih berlangsung, aplikasi menampilkan CircularProgressIndicator. Setelah proses selesai, aplikasi menampilkan teks hasil dari Future. Future dibuat pada initState(), bukan di dalam build(), agar proses tidak dijalankan berulang kali ketika widget dibangun kembali.

## 4. Bagian B — Menyiapkan Paket HTTP

Pada bagian B aplikasi dipersiapkan agar dapat mengambil data dari internet menggunakan paket http. Paket tersebut dipasang dengan perintah flutter pub add http. Untuk aplikasi Android release, diperlukan izin akses internet pada AndroidManifest.xml menggunakan permission INTERNET. Dengan paket http, aplikasi dapat mengirim permintaan HTTP seperti GET kepada REST API.

## 5. Bagian C — Model dan Fungsi Pengambil Data

Pada bagian C dibuat class Pengguna yang memiliki data id, name, email, phone, dan website. Data JSON dari API diubah menjadi objek Pengguna menggunakan factory constructor fromJson. Fungsi ambilPengguna() digunakan untuk mengambil data dari endpoint https://jsonplaceholder.typicode.com/users menggunakan metode GET. Setelah mendapatkan response, status response diperiksa. Jika statusCode bukan 200, fungsi menghasilkan Exception. Jika berhasil, data JSON diubah menggunakan jsonDecode() dan setiap data diubah menjadi objek Pengguna.

## 6. Bagian D — Menampilkan Data dengan FutureBuilder

Pada bagian D dibuat halaman PenggunaPage untuk menampilkan data pengguna dari REST API. Data diambil menggunakan FutureBuilder<List<Pengguna>>. FutureBuilder menangani beberapa kondisi, yaitu loading, error, dan data berhasil. Ketika data sedang dimuat, aplikasi menampilkan CircularProgressIndicator. Jika terjadi kesalahan, aplikasi menampilkan pesan error dan tombol Coba lagi. Jika data berhasil diperoleh, data pengguna ditampilkan menggunakan ListView.builder. Pada AppBar juga terdapat tombol refresh untuk mengambil data kembali.

## 7. Bagian E — Halaman Detail

Pada bagian E dibuat halaman DetailPenggunaPage untuk menampilkan informasi lengkap dari pengguna yang dipilih. Ketika salah satu pengguna pada daftar ditekan, aplikasi berpindah ke halaman detail. Halaman tersebut menampilkan email, nomor telepon, dan website pengguna. Data pengguna dikirim dari halaman daftar menuju halaman detail melalui parameter pengguna.

## 8. Bagian F — Percobaan Penanganan Galat

Pada bagian F dilakukan percobaan untuk mengetahui bagaimana aplikasi menangani kesalahan. Percobaan pertama dilakukan dengan mengubah URL API menjadi endpoint yang tidak tersedia sehingga menghasilkan status 404. Setelah itu URL dikembalikan ke URL yang benar dan tombol Coba lagi digunakan. Percobaan kedua dilakukan dengan mematikan koneksi internet perangkat atau emulator sehingga muncul kesalahan jaringan. Setelah koneksi internet dinyalakan kembali, tombol Coba lagi digunakan untuk mengambil data.

## 9. Latihan Mandiri

Latihan mandiri pada Pertemuan 4 terdiri dari beberapa pengembangan. Pertama, menambahkan username dan kota pada model pengguna, dengan data kota diambil dari data bersarang json['address']['city'] dan ditampilkan pada halaman detail. Kedua, membungkus ListView menggunakan RefreshIndicator agar pengguna dapat menarik layar ke bawah untuk memuat ulang data. Ketiga, menampilkan teks "Tidak ada data" apabila daftar pengguna kosong. Keempat, menambahkan Text pada AppBar yang menampilkan jumlah pengguna setelah data berhasil dimuat.

## 10. Tugas — Aplikasi Daftar Postingan

Pada tugas Pertemuan 4 dibuat aplikasi Daftar Postingan menggunakan endpoint /posts dan /posts/{id}/comments. Halaman utama menampilkan daftar postingan yang berisi judul dan potongan isi menggunakan FutureBuilder. Ketika sebuah postingan dipilih, aplikasi membuka halaman detail yang menampilkan isi lengkap postingan dan daftar komentar yang diambil dari endpoint terpisah. Aplikasi menggunakan model Post dan Komentar dengan fromJson. Kode pengambilan data dipisahkan dari kode UI. Aplikasi juga harus menangani kondisi loading dan error pada halaman yang digunakan serta menyediakan tombol coba lagi.

## 11. Refleksi

### 1. Apa yang terjadi bila Future dibuat di dalam build() dan bukan di initState()?

Jika Future dibuat di dalam build(), proses pengambilan data dapat dijalankan kembali setiap kali build() dipanggil. Hal tersebut dapat menyebabkan data dimuat berulang kali. Oleh karena itu, pada praktikum Future dibuat di dalam initState() sehingga proses pengambilan data tidak diulang setiap kali UI dibangun kembali.

### 2. Apa perbedaan snapshot.hasError dengan memeriksa response.statusCode?

response.statusCode digunakan untuk memeriksa status dari response HTTP yang diterima dari server. Sementara itu, snapshot.hasError digunakan oleh FutureBuilder untuk mengetahui apakah Future mengalami kesalahan. Keduanya diperlukan karena kesalahan dapat berasal dari response HTTP maupun proses pengambilan data.

### 3. Mengapa data JSON sebaiknya diubah menjadi class model?

Data JSON sebaiknya diubah menjadi class model agar struktur data lebih jelas dan lebih mudah digunakan di dalam aplikasi. Dengan class model, data pengguna dapat diakses menggunakan properti seperti id, name, email, phone, dan website daripada menggunakan Map secara langsung.

### 4. Mengapa UI wajib menyediakan status loading dan error?

Pengambilan data dari internet membutuhkan waktu dan dapat mengalami kegagalan. Status loading memberikan informasi bahwa aplikasi sedang mengambil data, sedangkan status error memberikan informasi ketika proses pengambilan data mengalami masalah. Dengan demikian, pengguna mengetahui kondisi aplikasi dan dapat mencoba kembali ketika terjadi kesalahan.

## 12. Kesimpulan

Praktikum Pertemuan 4 memberikan pemahaman mengenai pemrograman asinkron pada Dart menggunakan Future, async, dan await. Praktikum juga mempelajari cara mengambil data dari REST API menggunakan paket http dan JSON, membuat class model menggunakan fromJson, serta menampilkan data menggunakan FutureBuilder. Selain itu, praktikum mengajarkan cara menangani kondisi loading, error, dan kegagalan jaringan serta menyediakan tombol coba lagi. Melalui latihan dan tugas Daftar Postingan, konsep pengambilan dan pengelolaan data dari API dapat diterapkan dalam aplikasi Flutter.

## 13. Ringkasan untuk Laporan

Pada praktikum Pertemuan 4 dipelajari pemrograman asinkron pada Dart menggunakan Future, async, dan await serta pengambilan data dari REST API menggunakan paket http dan JSON. Data dari API JSONPlaceholder diubah menjadi class model menggunakan fromJson dan ditampilkan pada aplikasi Flutter menggunakan FutureBuilder dengan kondisi loading, error, dan data. Praktikum juga membahas halaman detail, tombol refresh, penanganan kesalahan jaringan, latihan pengembangan tampilan, serta pembuatan aplikasi Daftar Postingan yang mengambil data postingan dan komentar dari REST API.