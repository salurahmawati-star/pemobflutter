# Praktikum 3 - Form Input dan State Management

## 1. Deskripsi Praktikum

Praktikum ini membahas penerapan form input dan state management pada aplikasi Flutter. Pada praktikum ini, dibuat aplikasi **Daftar Belanja** yang memungkinkan pengguna menambahkan barang, melihat daftar barang, menandai barang yang sudah dibeli, dan menghapus barang dari daftar. Aplikasi ini menggunakan validasi input untuk memastikan data yang dimasukkan sesuai dengan ketentuan serta menggunakan `ChangeNotifier` dan `Provider` untuk mengelola data agar dapat digunakan oleh beberapa halaman.

## 2. Tujuan Praktikum

Tujuan dari praktikum ini adalah:
- Memahami cara menerima input pengguna menggunakan widget Flutter.
- Menerapkan validasi pada formulir agar data yang dimasukkan sesuai ketentuan.
- Memahami penggunaan `ChangeNotifier` sebagai pengelola perubahan data.
- Menerapkan state management menggunakan package `Provider`.
- Memahami penggunaan `context.watch` dan `context.read`.
- Membuat aplikasi yang dapat memperbarui tampilan secara otomatis ketika data berubah.

## 3. Fitur Aplikasi

Aplikasi Daftar Belanja memiliki beberapa fitur utama, yaitu:

1. **Form Tambah Barang**  
   Pengguna dapat memasukkan nama barang, jumlah barang, dan memilih kategori melalui dropdown.

2. **Validasi Input**  
   Nama barang wajib diisi, jumlah harus berupa angka yang lebih besar dari nol, dan kategori harus dipilih sebelum data disimpan.

3. **Daftar Belanja**  
   Barang yang berhasil ditambahkan akan ditampilkan pada halaman daftar belanja beserta informasi nama, jumlah, dan kategorinya.

4. **Status Pembelian**  
   Pengguna dapat menandai barang sebagai sudah dibeli melalui checkbox.

5. **Hapus Barang**  
   Pengguna dapat menghapus barang yang tidak diperlukan lagi dari daftar belanja.

6. **Jumlah Barang Belum Dibeli**  
   AppBar menampilkan jumlah barang yang belum dibeli dan diperbarui ketika status barang berubah atau barang dihapus.

## 4. Teknologi yang Digunakan

- **Flutter:** Framework untuk membangun antarmuka aplikasi.
- **Dart:** Bahasa pemrograman yang digunakan dalam pengembangan aplikasi Flutter.
- **Provider:** Package untuk membantu menyediakan dan mengakses data bersama di berbagai widget.
- **ChangeNotifier:** Class yang digunakan untuk memberi tahu widget ketika terjadi perubahan data.
- **Material Design:** Digunakan untuk membangun tampilan aplikasi dengan widget seperti AppBar, TextFormField, DropdownButton, dan Checkbox.

## 5. Konsep yang Dipelajari

Pada praktikum ini, `Form` dan `TextFormField` digunakan untuk menerima serta memvalidasi input pengguna. `ChangeNotifier` digunakan untuk mengelola data barang, sedangkan `Provider` memungkinkan halaman formulir dan halaman daftar mengakses data yang sama.

Penggunaan `context.watch` memungkinkan widget memantau perubahan data sehingga tampilannya diperbarui secara otomatis. Sementara itu, `context.read` digunakan untuk mengakses model dan menjalankan fungsi, seperti menambahkan barang, mengubah status pembelian, atau menghapus barang, tanpa berlangganan perubahan data.

## 6. Cara Menjalankan Aplikasi

1. Buka proyek Flutter menggunakan Android Studio.
2. Pastikan Flutter SDK dan perangkat emulator atau HP Android sudah tersedia.
3. Buka terminal pada folder utama proyek.
4. Jalankan perintah berikut untuk mengunduh dependensi yang dibutuhkan:

   ```bash
   flutter pub get
   ```

5. Jalankan aplikasi menggunakan perintah:

   ```bash
   flutter run
   ```

6. Uji fitur aplikasi dengan menambahkan barang, mencoba validasi input, menandai barang yang sudah dibeli, dan menghapus barang dari daftar.

## 7. Hasil Praktikum

Hasil dari praktikum ini adalah aplikasi Daftar Belanja yang memiliki halaman formulir untuk menambahkan barang dan halaman daftar untuk mengelola barang belanja. Validasi ditampilkan apabila pengguna memasukkan data yang tidak sesuai. Data barang juga dapat diperbarui melalui fitur penambahan, perubahan status pembelian, dan penghapusan barang.

## 8. Refleksi

Melalui praktikum ini, saya memahami cara membuat formulir input dan menerapkan validasi data pada aplikasi Flutter. Saya juga mempelajari perbedaan penggunaan `setState` dan `Provider`, serta bagaimana `ChangeNotifier` membantu mengelola data yang digunakan oleh beberapa halaman. Selain itu, saya memahami pentingnya memanggil `notifyListeners()` agar perubahan data dapat diketahui oleh widget yang memantau data tersebut.

## 9. Kesimpulan

Praktikum ini memberikan pemahaman mengenai penggunaan form input, validasi data, dan state management dalam pengembangan aplikasi Flutter. Dengan menerapkan `ChangeNotifier` dan `Provider`, pengelolaan data menjadi lebih terstruktur karena data dapat digunakan bersama oleh beberapa halaman. Fitur penambahan, penandaan status pembelian, dan penghapusan barang juga membantu memahami bagaimana perubahan data dapat memengaruhi tampilan aplikasi secara otomatis.

## 10. Dokumentasi

Tambahkan screenshot berikut sebagai bukti hasil pengerjaan praktikum:

- Screenshot halaman daftar belanja.
- Screenshot halaman formulir tambah barang.
- Screenshot validasi ketika input tidak sesuai.
- Screenshot ketika barang berhasil ditambahkan atau ditandai sudah dibeli.
