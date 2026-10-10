import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

// ==================================================
// MODEL CATATAN
// ==================================================

class Catatan {
  final int? id;
  final String judul;
  final String isi;

  Catatan({
    this.id,
    required this.judul,
    required this.isi,
  });

  // Mengubah object menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
    };
  }

  // Mengubah Map menjadi object Catatan
  factory Catatan.fromMap(Map<String, dynamic> map) {
    return Catatan(
      id: map['id'],
      judul: map['judul'],
      isi: map['isi'],
    );
  }
}

// ==================================================
// DATABASE HELPER
// ==================================================

class DbHelper {
  DbHelper._();

  static final DbHelper instance = DbHelper._();

  Database? _db;

  // Membuka database
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = p.join(
      dbPath,
      'catatan.db',
    );

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE catatan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            isi TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // ==================================================
  // CREATE
  // ==================================================

  Future<int> tambah(Catatan catatan) async {
    final db = await database;

    return db.insert(
      'catatan',
      catatan.toMap(),
    );
  }

  // ==================================================
  // READ
  // ==================================================

  Future<List<Catatan>> semua() async {
    final db = await database;

    final data = await db.query(
      'catatan',
      orderBy: 'id DESC',
    );

    return data
        .map(
          (map) => Catatan.fromMap(map),
    )
        .toList();
  }

  // ==================================================
  // UPDATE
  // ==================================================

  Future<int> ubah(Catatan catatan) async {
    final db = await database;

    return db.update(
      'catatan',
      catatan.toMap(),
      where: 'id = ?',
      whereArgs: [catatan.id],
    );
  }

  // ==================================================
  // DELETE
  // ==================================================

  Future<int> hapus(int id) async {
    final db = await database;

    return db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ==================================================
// APLIKASI
// ==================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const CatatanPage(),
    );
  }
}

// ==================================================
// HALAMAN CATATAN
// ==================================================

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  late Future<List<Catatan>> _future;

  @override
  void initState() {
    super.initState();
    _muatCatatan();
  }

  void _muatCatatan() {
    _future = DbHelper.instance.semua();
  }

  void _refresh() {
    setState(() {
      _muatCatatan();
    });
  }

  // ==================================================
  // HAPUS CATATAN
  // ==================================================

  Future<void> _hapusCatatan(int id) async {
    await DbHelper.instance.hapus(id);

    if (!mounted) return;

    _refresh();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan berhasil dihapus'),
      ),
    );
  }

  // ==================================================
  // TAMBAH / EDIT
  // ==================================================

  Future<void> _bukaForm([Catatan? catatan]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormCatatanPage(
          catatan: catatan,
        ),
      ),
    );

    _refresh();
  }

  // ==================================================
  // BUILD
  // ==================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan SQLite'),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: FutureBuilder<List<Catatan>>(
        future: _future,

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi error: ${snapshot.error}',
              ),
            );
          }

          final catatan = snapshot.data ?? [];

          // Data kosong
          if (catatan.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada catatan',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          // Menampilkan data
          return ListView.builder(
            itemCount: catatan.length,
            itemBuilder: (context, index) {
              final item = catatan[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      '${item.id}',
                    ),
                  ),

                  title: Text(
                    item.judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    item.isi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  onTap: () {
                    _bukaForm(item);
                  },

                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      _hapusCatatan(item.id!);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      // Tombol tambah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bukaForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==================================================
// FORM TAMBAH / EDIT CATATAN
// ==================================================

class FormCatatanPage extends StatefulWidget {
  final Catatan? catatan;

  const FormCatatanPage({
    super.key,
    this.catatan,
  });

  @override
  State<FormCatatanPage> createState() =>
      _FormCatatanPageState();
}

class _FormCatatanPageState
    extends State<FormCatatanPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController =
  TextEditingController();

  final TextEditingController _isiController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.catatan != null) {
      _judulController.text =
          widget.catatan!.judul;

      _isiController.text =
          widget.catatan!.isi;
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  // ==================================================
  // SIMPAN
  // ==================================================

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final catatan = Catatan(
      id: widget.catatan?.id,
      judul: _judulController.text.trim(),
      isi: _isiController.text.trim(),
    );

    if (widget.catatan == null) {
      await DbHelper.instance.tambah(catatan);
    } else {
      await DbHelper.instance.ubah(catatan);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  // ==================================================
  // BUILD
  // ==================================================

  @override
  Widget build(BuildContext context) {
    final sedangEdit = widget.catatan != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          sedangEdit
              ? 'Edit Catatan'
              : 'Tambah Catatan',
        ),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // Judul
            TextFormField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            // Isi
            TextFormField(
              controller: _isiController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Isi Catatan',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Isi catatan wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            // Tombol simpan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _simpan,
                child: Text(
                  sedangEdit
                      ? 'Update Catatan'
                      : 'Simpan Catatan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}