import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _gelap = false;

  @override
  void initState() {
    super.initState();
    _muatTema();
  }

  // Mengambil status tema dari SharedPreferences
  Future<void> _muatTema() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _gelap = prefs.getBool('gelap') ?? false;
    });
  }

  // Mengubah tema aplikasi
  Future<void> _ubahTema(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('gelap', value);

    setState(() {
      _gelap = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Tema terang
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),

      // Tema gelap
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      // Menentukan tema yang digunakan
      themeMode: _gelap ? ThemeMode.dark : ThemeMode.light,

      home: Praktikum5A(
        gelap: _gelap,
        onTemaChanged: _ubahTema,
      ),
    );
  }
}

// ===============================
// HALAMAN PRAKTIKUM 5A
// ===============================

class Praktikum5A extends StatefulWidget {
  final bool gelap;
  final Function(bool) onTemaChanged;

  const Praktikum5A({
    super.key,
    required this.gelap,
    required this.onTemaChanged,
  });

  @override
  State<Praktikum5A> createState() => _Praktikum5AState();
}

class _Praktikum5AState extends State<Praktikum5A> {
  final TextEditingController _namaController = TextEditingController();

  String _nama = '';
  int _jumlahBuka = 0;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  // ===============================
  // MEMUAT DATA
  // ===============================

  Future<void> _muatData() async {
    final prefs = await SharedPreferences.getInstance();

    // Mengambil nama yang tersimpan
    final nama = prefs.getString('nama') ?? '';

    // Mengambil jumlah buka aplikasi
    int jumlahBuka = prefs.getInt('jumlah_buka') ?? 0;

    // Menambah jumlah buka
    jumlahBuka++;

    // Menyimpan jumlah buka terbaru
    await prefs.setInt('jumlah_buka', jumlahBuka);

    if (!mounted) return;

    setState(() {
      _nama = nama;
      _jumlahBuka = jumlahBuka;
      _namaController.text = nama;
    });
  }

  // ===============================
  // MENYIMPAN NAMA
  // ===============================

  Future<void> _simpanNama() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'nama',
      _namaController.text,
    );

    if (!mounted) return;

    setState(() {
      _nama = _namaController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nama berhasil disimpan'),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  // ===============================
  // TAMPILAN
  // ===============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Judul
            const Text(
              'Penyimpanan Data Lokal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // ===============================
            // INPUT NAMA
            // ===============================

            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan nama',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _simpanNama,
                child: const Text('Simpan Nama'),
              ),
            ),

            const SizedBox(height: 20),

            // Nama tersimpan
            Text(
              'Nama tersimpan: $_nama',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            // ===============================
            // MODE GELAP
            // ===============================

            SwitchListTile(
              title: const Text('Mode Gelap'),
              subtitle: Text(
                widget.gelap
                    ? 'Mode gelap aktif'
                    : 'Mode terang aktif',
              ),
              value: widget.gelap,
              onChanged: widget.onTemaChanged,
            ),

            const SizedBox(height: 10),

            // ===============================
            // JUMLAH BUKA
            // ===============================

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.visibility,
                ),
                title: const Text(
                  'Jumlah Dibuka',
                ),
                subtitle: Text(
                  'Aplikasi sudah dibuka $_jumlahBuka kali',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}