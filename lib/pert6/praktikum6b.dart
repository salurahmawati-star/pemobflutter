import 'package:flutter/material.dart';

// ======================================================
// MODEL ITEM
// ======================================================

class Item {
  final String nama;
  final IconData ikon;
  final Color warna;

  const Item(
      this.nama,
      this.ikon,
      this.warna,
      );
}

// ======================================================
// DATA ITEM
// ======================================================

const daftarItem = [
  Item(
    'Flutter',
    Icons.flutter_dash,
    Colors.blue,
  ),
  Item(
    'Musik',
    Icons.music_note,
    Colors.pink,
  ),
  Item(
    'Kamera',
    Icons.camera_alt,
    Colors.orange,
  ),
  Item(
    'Peta',
    Icons.map,
    Colors.green,
  ),
];

// ======================================================
// MAIN
// ======================================================

void main() {
  runApp(const MyApp());
}

// ======================================================
// MY APP
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 6B',
      debugShowCheckedModeBanner: false,

      // Tema
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),

      // Route awal
      initialRoute: '/',

      // Named Route
      routes: {
        '/': (context) => const BerandaTab(),
      },

      // Route halaman detail
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final item = settings.arguments as Item;

          return MaterialPageRoute(
            builder: (context) {
              return DetailPage(
                item: item,
              );
            },
          );
        }

        return null;
      },
    );
  }
}

// ======================================================
// BERANDA
// ======================================================

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarItem.length,

        itemBuilder: (context, index) {
          final item = daftarItem[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),

            child: ListTile(
              // ==================================================
              // HERO
              // ==================================================

              leading: Hero(
                tag: 'ikon-${item.nama}',

                child: CircleAvatar(
                  backgroundColor: item.warna,

                  child: Icon(
                    item.ikon,
                    color: tema.colorScheme.onPrimary,
                  ),
                ),
              ),

              // ==================================================
              // NAMA
              // ==================================================

              title: Text(
                item.nama,
                style: tema.textTheme.titleMedium,
              ),

              // ==================================================
              // SUBTITLE
              // ==================================================

              subtitle: const Text(
                'Tekan untuk melihat detail',
              ),

              // ==================================================
              // ICON PANAH
              // ==================================================

              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),

              // ==================================================
              // NAVIGASI
              // ==================================================

              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ======================================================
// DETAIL PAGE
// ======================================================

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.nama),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ==================================================
            // HERO
            // ==================================================

            Hero(
              tag: 'ikon-${item.nama}',

              child: CircleAvatar(
                radius: 60,
                backgroundColor: item.warna,

                child: Icon(
                  item.ikon,
                  size: 60,
                  color: tema.colorScheme.onPrimary,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // NAMA ITEM
            // ==================================================

            Text(
              item.nama,
              style: tema.textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            // ==================================================
            // DESKRIPSI
            // ==================================================

            Text(
              'Ini adalah halaman detail ${item.nama}.',
              style: tema.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // ==================================================
            // TOMBOL KEMBALI
            // ==================================================

            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back,
              ),

              label: const Text(
                'Kembali',
              ),
            ),
          ],
        ),
      ),
    );
  }
}