import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MODEL BARANG
class Barang {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Barang({
    required this.nama,
    required this.jumlah,
    required this.kategori,
    this.sudahDibeli = false,
  });
}

// CHANGE NOTIFIER
class BelanjaModel extends ChangeNotifier {
  final List<Barang> _daftarBarang = [];

  List<Barang> get daftarBarang => List.unmodifiable(_daftarBarang);

  int get jumlahBelumDibeli =>
      _daftarBarang.where((barang) => !barang.sudahDibeli).length;

  void tambahBarang(Barang barang) {
    _daftarBarang.add(barang);
    notifyListeners();
  }

  void ubahStatus(Barang barang, bool? nilai) {
    barang.sudahDibeli = nilai ?? false;
    notifyListeners();
  }

  void hapusBarang(Barang barang) {
    _daftarBarang.remove(barang);
    notifyListeners();
  }
}

// APLIKASI DAFTAR BELANJA
class Praktikum3Tugas extends StatelessWidget {
  const Praktikum3Tugas({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const DaftarBelanjaPage(),
    );
  }
}

// HALAMAN DAFTAR BELANJA
class DaftarBelanjaPage extends StatelessWidget {
  const DaftarBelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                'Belum dibeli: ${model.jumlahBelumDibeli}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: model.daftarBarang.isEmpty
          ? const Center(
        child: Text(
          'Belum ada barang.\nTekan + untuk menambahkan barang.',
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        itemCount: model.daftarBarang.length,
        itemBuilder: (context, index) {
          final barang = model.daftarBarang[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: Checkbox(
                value: barang.sudahDibeli,
                onChanged: (nilai) {
                  context
                      .read<BelanjaModel>()
                      .ubahStatus(barang, nilai);
                },
              ),
              title: Text(
                barang.nama,
                style: TextStyle(
                  decoration: barang.sudahDibeli
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                'Jumlah: ${barang.jumlah} | Kategori: ${barang.kategori}',
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  context.read<BelanjaModel>().hapusBarang(barang);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Barang berhasil dihapus'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          final model = context.read<BelanjaModel>();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: model,
                child: const TambahBarangPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// HALAMAN TAMBAH BARANG
class TambahBarangPage extends StatefulWidget {
  const TambahBarangPage({super.key});

  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();

  String? _kategori;

  final List<String> _kategoriList = [
    'Makanan',
    'Minuman',
    'Perlengkapan Rumah',
    'Kesehatan',
    'Lainnya',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpanBarang() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final barang = Barang(
      nama: _namaController.text.trim(),
      jumlah: int.parse(_jumlahController.text.trim()),
      kategori: _kategori!,
    );

    context.read<BelanjaModel>().tambahBarang(barang);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barang berhasil ditambahkan'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: Beras',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Nama barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text(
                'Jumlah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Contoh: 2',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Jumlah wajib diisi';
                  }

                  final jumlah = int.tryParse(nilai.trim());

                  if (jumlah == null) {
                    return 'Jumlah harus berupa angka';
                  }

                  if (jumlah <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text(
                'Kategori',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _kategori,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                hint: const Text('Pilih kategori'),
                items: _kategoriList.map((kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (nilai) {
                  setState(() {
                    _kategori = nilai;
                  });
                },
                validator: (nilai) {
                  if (nilai == null || nilai.isEmpty) {
                    return 'Kategori wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _simpanBarang,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Barang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MAIN
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Praktikum3Tugas(),
    ),
  );
}
