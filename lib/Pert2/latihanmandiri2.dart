import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;

  const Makanan(
      this.nama,
      this.harga,
      this.deskripsi,
      );
}

// Daftar menu
const daftarMenu = [
  Makanan(
    'Nasi Goreng',
    15000,
    'Nasi goreng dengan telur dan bumbu khas yang lezat.',
  ),
  Makanan(
    'Mie Ayam',
    12000,
    'Mie ayam dengan potongan ayam dan sayuran segar.',
  ),
  Makanan(
    'Es Teh',
    4000,
    'Minuman teh manis dingin yang menyegarkan.',
  ),
  Makanan(
    'Ayam Bakar',
    20000,
    'Ayam bakar dengan bumbu khas dan aroma yang menggugah selera.',
  ),
  Makanan(
    'Soto Ayam',
    13000,
    'Soto ayam hangat dengan kuah gurih dan isian lengkap.',
  ),
  Makanan(
    'Bakso',
    14000,
    'Bakso sapi dengan kuah gurih, mie, dan sayuran.',
  ),
  Makanan(
    'Jus Alpukat',
    10000,
    'Jus alpukat segar dengan rasa manis dan creamy.',
  ),
  Makanan(
    'Pudding Buah',
    12000,
    'Pudding Buah segar dengan rasa manis dan segar.',
  ),
  Makanan(
    'Seblak',
    12000,
    'Seblak pedas dengan kerupuk, sayuran, dan topping pilihan.',
  ),
  Makanan(
    'Kwetiau Goreng',
    16000,
    'Kwetiau goreng dengan telur, sayuran, dan bumbu gurih.',
  ),
  Makanan(
    'Pisang Coklat',
    10000,
    'Pisang goreng renyah dengan topping coklat manis.',
  ),
];

// Fungsi untuk format harga menjadi ribuan
String formatHarga(int harga) {
  return harga.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
      ),

      // ListView membuat daftar menu dapat di-scroll
      body: ListView.builder(
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.restaurant,
                color: Colors.blue,
              ),
              title: Text(
                item.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Rp ${formatHarga(item.harga)}',
              ),
              trailing: const Icon(Icons.chevron_right),

              // Navigasi ke halaman detail
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      makanan: item,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.nama),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                size: 80,
              ),

              const SizedBox(height: 16),

              Text(
                makanan.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Rp ${formatHarga(makanan.harga)}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                makanan.deskripsi,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}