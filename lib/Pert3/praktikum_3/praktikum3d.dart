
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ==================================================
// MODEL TUGAS
// ==================================================

class Tugas {
  final String judul;
  bool selesai;

  Tugas({
    required this.judul,
    this.selesai = false,
  });
}

// ==================================================
// STATE MANAGEMENT MENGGUNAKAN PROVIDER
// ==================================================

class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];

  List<Tugas> get items => List.unmodifiable(_items);

  int get jumlahSelesai =>
      _items.where((tugas) => tugas.selesai).length;

  void tambah(String judul) {
    _items.add(Tugas(judul: judul));
    notifyListeners();
  }

  void toggle(int index) {
    _items[index].selesai = !_items[index].selesai;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void hapusSelesai() {
    _items.removeWhere((tugas) => tugas.selesai);
    notifyListeners();
  }
}

// ==================================================
// MAIN PROGRAM
// ==================================================

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TugasModel(),
      child: const MyApp(),
    ),
  );
}

// ==================================================
// APLIKASI UTAMA
// ==================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum 3D',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const TugasPage(),
    );
  }
}

// ==================================================
// HALAMAN DAFTAR TUGAS
// ==================================================

class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Tugas '
              '(${model.jumlahSelesai}/${model.items.length})',
        ),
        actions: [
          IconButton(
            tooltip: 'Hapus tugas selesai',
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              if (model.jumlahSelesai == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Belum ada tugas yang selesai'),
                  ),
                );
                return;
              }

              context.read<TugasModel>().hapusSelesai();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tugas selesai berhasil dihapus'),
                ),
              );
            },
          ),
        ],
      ),
      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Belum ada tugas.\n'
              'Tekan tombol + untuk menambahkan tugas.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, index) {
          final tugas = model.items[index];

          return ListTile(
            leading: Checkbox(
              value: tugas.selesai,
              onChanged: (_) {
                context.read<TugasModel>().toggle(index);
              },
            ),
            title: Text(
              tugas.judul,
              style: TextStyle(
                decoration: tugas.selesai
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                context.read<TugasModel>().hapus(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah tugas',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahTugasPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==================================================
// HALAMAN TAMBAH TUGAS
// ==================================================

class TambahTugasPage extends StatefulWidget {
  const TambahTugasPage({super.key});

  @override
  State<TambahTugasPage> createState() =>
      _TambahTugasPageState();
}

class _TambahTugasPageState extends State<TambahTugasPage> {
  final TextEditingController _controller =
  TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void simpanTugas() {
    final judul = _controller.text.trim();

    if (judul.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Judul tugas minimal 3 karakter',
          ),
        ),
      );
      return;
    }

    context.read<TugasModel>().tambah(judul);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tugas ditambahkan'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Masukkan tugas baru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Judul Tugas',
                hintText: 'Contoh: Mengerjakan praktikum',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              onSubmitted: (_) => simpanTugas(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: simpanTugas,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}
