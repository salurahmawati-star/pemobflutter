# Penjelasan Praktikum Flutter Pertemuan 5

## 1. Tujuan Pembelajaran

Praktikum Pertemuan 5 membahas penyimpanan lokal pada aplikasi Flutter menggunakan SharedPreferences dan SQLite. Tujuan praktikum adalah memahami pemilihan jenis penyimpanan lokal yang sesuai, menyimpan dan membaca pengaturan sederhana menggunakan shared_preferences, membuat tabel dan database SQLite menggunakan sqflite, menerapkan operasi CRUD, menghubungkan database dengan UI, serta memastikan data tetap tersedia setelah aplikasi ditutup dan dibuka kembali.

## 2. Teori Singkat

Data yang hanya disimpan di dalam memori seperti variabel dan State akan hilang ketika aplikasi ditutup. Agar data tetap tersedia, aplikasi membutuhkan penyimpanan permanen atau persistence pada perangkat. SharedPreferences digunakan untuk menyimpan data sederhana berbentuk key-value seperti tema, nama, status login, dan angka terakhir. SQLite digunakan untuk data yang lebih terstruktur dan jumlahnya banyak seperti catatan, transaksi, dan daftar produk. Selain itu, penyimpanan berbentuk berkas dapat digunakan untuk dokumen, gambar, atau proses ekspor dan impor data. Dalam SQLite terdapat operasi CRUD yaitu Create, Read, Update, dan Delete yang dapat dilakukan menggunakan db.insert(), db.query(), db.update(), dan db.delete().

## 3. Bagian A — SharedPreferences

Pada bagian A digunakan SharedPreferences untuk menyimpan pengaturan sederhana berupa nama, pilihan mode gelap, dan jumlah berapa kali aplikasi dibuka. Data dibaca menggunakan getString(), getBool(), dan getInt(), sedangkan data disimpan menggunakan setString(), setBool(), dan setInt(). Fungsi _muat() dipanggil pada initState() untuk mengambil data yang sebelumnya sudah tersimpan. Setelah aplikasi dihentikan sepenuhnya dan dijalankan kembali, nama dan mode gelap tetap tersedia serta jumlah pembukaan aplikasi bertambah.

## 4. Bagian B — Menyiapkan SQLite

Pada bagian B digunakan paket sqflite dan path untuk membuat penyimpanan menggunakan SQLite. Dibuat class Catatan sebagai model yang memiliki id, judul, dan isi. Kemudian dibuat class DbHelper untuk mengelola database. Database yang digunakan bernama catatan.db dan memiliki tabel catatan dengan kolom id sebagai primary key dengan AUTOINCREMENT, judul, dan isi. DbHelper menyediakan fungsi tambah(), semua(), ubah(), dan hapus() untuk menjalankan operasi CRUD. Pada proses update dan delete digunakan placeholder ? dan whereArgs agar nilai tidak langsung digabungkan ke query.

## 5. Bagian C — Halaman Daftar Catatan

Pada bagian C dibuat CatatanPage untuk menampilkan daftar catatan yang tersimpan di SQLite. Data diambil menggunakan DbHelper.semua() dan ditampilkan menggunakan FutureBuilder. Halaman menangani beberapa kondisi, yaitu loading, error, data kosong, dan data berhasil diperoleh. Jika data tersedia, catatan ditampilkan menggunakan ListView.builder dan ListTile. Pengguna dapat mengetuk catatan untuk membuka halaman perubahan data atau menggunakan tombol hapus untuk menghapus catatan. FloatingActionButton digunakan untuk membuka form penambahan catatan.

## 6. Bagian D — Form Tambah dan Ubah Catatan

Pada bagian D dibuat FormCatatanPage yang digunakan untuk menambah dan mengubah catatan. Satu halaman form digunakan untuk dua kondisi. Jika catatan belum ada, form digunakan untuk menambah data baru. Jika catatan sudah ada, data sebelumnya ditampilkan pada form dan dapat diubah. Form menggunakan TextFormField untuk judul dan isi catatan serta memiliki validasi agar kedua bagian tersebut wajib diisi. Ketika tombol Simpan ditekan, aplikasi menggunakan DbHelper.tambah() untuk data baru atau DbHelper.ubah() untuk data yang sudah ada. Setelah proses selesai, halaman form ditutup dan kembali ke daftar catatan.

## 7. Latihan Mandiri

Latihan mandiri pada Pertemuan 5 terdiri dari empat pengembangan. Pertama, menampilkan AlertDialog dengan pertanyaan "Hapus catatan ini?" sebelum data benar-benar dihapus. Kedua, menambahkan kolom pencarian yang memfilter daftar berdasarkan judul menggunakan where: 'judul LIKE ?' dan whereArgs: ['%$kata%']. Ketiga, menambahkan kolom dibuat untuk menyimpan tanggal dibuat, menaikkan database menjadi version 2, dan menggunakan onUpgrade dengan perintah ALTER TABLE catatan ADD COLUMN dibuat TEXT. Keempat, menyimpan pilihan urutan terbaru atau terlama menggunakan SharedPreferences dan menerapkannya pada orderBy.

## 8. Tugas — Aplikasi Pencatat Pengeluaran

Pada tugas Pertemuan 5 dibuat aplikasi Pencatat Pengeluaran dengan menggunakan SQLite sebagai penyimpanan data lokal. Tabel pengeluaran terdiri dari id, nama, jumlah, kategori, dan tanggal. Aplikasi harus memiliki fitur CRUD lengkap berupa daftar, tambah, ubah, dan hapus. Form pengeluaran memiliki validasi dengan ketentuan nama wajib diisi, jumlah harus berupa angka lebih dari 0, dan kategori dipilih melalui dropdown. Aplikasi juga harus menampilkan total seluruh pengeluaran pada halaman utama yang dapat dihitung menggunakan Dart atau SELECT SUM(jumlah). Selain itu, satu pengaturan seperti mode gelap atau kategori filter terakhir harus disimpan menggunakan SharedPreferences. Data pengeluaran harus tetap tersedia setelah aplikasi ditutup dan dibuka kembali.

## 9. Rubrik Penilaian

| Komponen | Bobot |
|---|---:|
| Bagian A–D berjalan (checkpoint) | 30% |
| Latihan mandiri | 20% |
| Tugas Pencatat Pengeluaran | 40% |
| Kerapian kode | 10% |

Kerapian kode mencakup model, akses data, dan UI yang dibuat dengan struktur yang baik.

## 10. Refleksi

### 1. Mengapa shared_preferences kurang cocok untuk menyimpan ratusan catatan? Apa pilihan yang lebih baik?

SharedPreferences kurang cocok untuk menyimpan ratusan catatan karena digunakan untuk data sederhana berbentuk key-value. Untuk menyimpan data yang banyak dan terstruktur seperti catatan, pilihan yang lebih baik adalah SQLite menggunakan sqflite.

### 2. Mengapa query memakai placeholder ? dan whereArgs, bukan menyambung teks langsung?

Placeholder ? dan whereArgs digunakan agar nilai tidak langsung disambungkan ke teks query. Cara tersebut membantu membuat query lebih aman dan menghindari risiko SQL injection.

### 3. Mengapa setelah kembali dari halaman form, daftar perlu dimuat ulang? Bagaimana caranya pada kode ini?

Daftar perlu dimuat ulang karena data dapat berubah setelah pengguna menambah atau mengubah catatan pada halaman form. Pada kode praktikum, setelah Navigator.push() selesai, fungsi _muat() dipanggil untuk mengambil data terbaru dari database dan memperbarui daftar.

### 4. Apa fungsi onCreate dan onUpgrade, dan kapan masing-masing dijalankan?

onCreate digunakan ketika database pertama kali dibuat untuk membuat tabel dan struktur awal database. Sedangkan onUpgrade digunakan ketika versi database dinaikkan dan struktur database perlu diperbarui, misalnya ketika menambahkan kolom baru pada tabel.

## 11. Kesimpulan

Praktikum Pertemuan 5 memberikan pemahaman mengenai penyimpanan data secara lokal pada Flutter menggunakan SharedPreferences dan SQLite. SharedPreferences digunakan untuk menyimpan pengaturan sederhana, sedangkan SQLite digunakan untuk menyimpan data terstruktur melalui operasi CRUD. Praktikum juga mempelajari pembuatan model, pengelolaan database menggunakan DbHelper, penampilan data dengan FutureBuilder, serta pembuatan form untuk menambah dan mengubah data. Melalui latihan mandiri dan tugas Pencatat Pengeluaran, konsep penyimpanan lokal dikembangkan dengan fitur pencarian, konfirmasi penghapusan, upgrade database, total pengeluaran, validasi, pengaturan menggunakan SharedPreferences, dan persistence agar data tetap tersedia setelah aplikasi ditutup dan dibuka kembali.

## 12. Ringkasan untuk Laporan

Pada praktikum Pertemuan 5 dipelajari penyimpanan lokal pada Flutter menggunakan SharedPreferences dan SQLite. SharedPreferences digunakan untuk menyimpan pengaturan sederhana seperti nama, mode gelap, dan jumlah pembukaan aplikasi, sedangkan SQLite digunakan untuk menyimpan data terstruktur melalui tabel dan operasi CRUD. Praktikum dilanjutkan dengan pembuatan halaman daftar dan form tambah atau ubah catatan, latihan pencarian, konfirmasi penghapusan, penambahan kolom tanggal, upgrade database, serta penyimpanan pilihan urutan. Pada tugas akhir dibuat aplikasi Pencatat Pengeluaran yang memiliki fitur CRUD, validasi form, total pengeluaran, satu pengaturan menggunakan SharedPreferences, dan persistence agar data tetap tersedia setelah aplikasi ditutup dan dibuka kembali.