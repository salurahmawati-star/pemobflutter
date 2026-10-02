# Praktikum 2: Layout, ListView, dan Navigasi Antar Halaman

## 1. Penjelasan Praktikum

Praktikum ini membahas penggunaan widget Flutter untuk mengatur tata letak, menampilkan daftar data, dan melakukan navigasi antarhalaman. Widget `Container`, `Padding`, `Row`, `Column`, dan `Expanded` digunakan untuk menyusun tampilan kartu profil agar lebih rapi. Selanjutnya, class model data digunakan untuk menyimpan informasi, sedangkan `ListView.builder`, `Card`, dan `ListTile` digunakan untuk menampilkan daftar menu makanan dan kontak.

Pada bagian navigasi, `Navigator.push()` digunakan untuk membuka halaman detail, sedangkan `Navigator.pop()` digunakan untuk kembali ke halaman sebelumnya. Konsep tersebut diterapkan dalam aplikasi daftar kontak yang menampilkan nama, nomor telepon, dan email. Pengguna dapat memilih kontak untuk melihat informasi lengkapnya.

## 2. Refleksi

### 2.1 Apa perbedaan ListView dan ListView.builder?

`ListView` digunakan untuk menampilkan daftar secara langsung, sedangkan `ListView.builder` membuat item daftar sesuai kebutuhan. `ListView.builder` cocok digunakan ketika menampilkan banyak data karena item dibuat secara bertahap.

### 2.2 Mengapa Row dapat mengalami overflow dan bagaimana cara mengatasinya?

`Row` dapat mengalami overflow ketika total lebar widget di dalamnya melebihi ruang yang tersedia. Salah satu cara mengatasinya adalah menggunakan `Expanded` agar widget dapat menyesuaikan ruang yang tersedia.

### 2.3 Bagaimana cara mengirim data ke halaman detail?

Data dapat dikirim melalui parameter pada halaman detail ketika menggunakan `Navigator.push()`. Data yang diterima kemudian digunakan untuk menampilkan informasi sesuai item yang dipilih. Pengguna dapat kembali ke halaman sebelumnya menggunakan `Navigator.pop()`.

## 3. Kesimpulan

Berdasarkan praktikum yang telah dilakukan, Flutter menyediakan berbagai widget untuk membuat tampilan aplikasi yang rapi dan interaktif. Penggunaan `Container`, `Padding`, `Row`, `Column`, dan `Expanded` membantu mengatur tata letak, sedangkan `ListView.builder` digunakan untuk menampilkan data dalam bentuk daftar. Selain itu, penggunaan model data dan navigasi dengan `Navigator.push()` serta `Navigator.pop()` memungkinkan pengguna melihat informasi detail dan berpindah antarhalaman. Melalui praktikum ini, pemahaman mengenai tata letak, pengelolaan data, dan navigasi pada aplikasi Flutter menjadi lebih baik.