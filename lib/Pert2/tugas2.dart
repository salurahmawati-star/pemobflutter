import 'package:flutter/material.dart';

class Kontak {
  final String nama;
  final String telepon;
  final String email;

  const Kontak(
      this.nama,
      this.telepon,
      this.email,
      );
}

const daftarKontak = [
  Kontak(
    'Andi',
    '081234567890',
    'andi@gmail.com',
  ),
  Kontak(
    'Budi',
    '082345678901',
    'budi@gmail.com',
  ),
  Kontak(
    'Citra',
    '083456789012',
    'citra@gmail.com',
  ),
  Kontak(
    'Dina',
    '084567890123',
    'dina@gmail.com',
  ),
  Kontak(
    'Eko',
    '085678901234',
    'eko@gmail.com',
  ),
  Kontak(
    'Fajar',
    '086789012345',
    'fajar@gmail.com',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),

      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          return ListTile(
            // Avatar huruf pertama nama
            leading: CircleAvatar(
              child: Text(
                kontak.nama[0],
              ),
            ),

            // Nama kontak
            title: Text(
              kontak.nama,
            ),

            // Nomor telepon
            subtitle: Text(
              kontak.telepon,
            ),

            // Icon panah
            trailing: const Icon(
              Icons.chevron_right,
            ),

            // Klik kontak
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactDetailPage(
                    kontak: kontak,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final Kontak kontak;

  const ContactDetailPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kontak.nama,
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Avatar besar
            CircleAvatar(
              radius: 50,
              child: Text(
                kontak.nama[0],
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Nama
            Text(
              kontak.nama,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Nomor telepon
            Text(
              'Nomor Telepon',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              kontak.telepon,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            // Email
            Text(
              'Email',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              kontak.email,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            // Tombol kembali
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Kembali',
              ),
            ),
          ],
        ),
      ),
    );
  }
}