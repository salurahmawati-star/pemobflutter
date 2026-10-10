import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pengguna {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String city;

  Pengguna({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.city,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      city: json['address']['city'],
    );
  }
}

// ======================================================
// AMBIL DATA PENGGUNA
// ======================================================

Future<List<Pengguna>> ambilPengguna() async {
  final response = await http.get(
    Uri.parse(
      'https://jsonplaceholder.typicode.com/users',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((json) => Pengguna.fromJson(json))
        .toList();
  } else {
    throw Exception(
      'Gagal mengambil data',
    );
  }
}

// ======================================================
// HALAMAN PENGGUNA
// ======================================================

class PenggunaPage extends StatefulWidget {
  const PenggunaPage({super.key});

  @override
  State<PenggunaPage> createState() => _PenggunaPageState();
}

class _PenggunaPageState extends State<PenggunaPage> {
  late Future<List<Pengguna>> _future;

  @override
  void initState() {
    super.initState();

    _future = ambilPengguna();
  }

  // ====================================================
  // MUAT ULANG
  // ====================================================

  void _muatUlang() {
    setState(() {
      _future = ambilPengguna();
    });
  }

  // ====================================================
  // REFRESH INDICATOR
  // ====================================================

  Future<void> _refresh() async {
    final futureBaru = ambilPengguna();

    setState(() {
      _future = futureBaru;
    });

    await futureBaru;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<Pengguna>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Daftar Pengguna (${snapshot.data!.length})',
              );
            }

            return const Text(
              'Daftar Pengguna',
            );
          },
        ),
      ),

      body: FutureBuilder<List<Pengguna>>(
        future: _future,

        builder: (context, snapshot) {
          // ==================================================
          // LOADING
          // ==================================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ==================================================
          // ERROR
          // ==================================================

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  const Text(
                    'Terjadi kesalahan saat mengambil data',
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: _muatUlang,
                    child: const Text(
                      'Coba Lagi',
                    ),
                  ),
                ],
              ),
            );
          }

          // ==================================================
          // DATA
          // ==================================================

          final pengguna = snapshot.data ?? [];

          // ==================================================
          // JIKA DATA KOSONG
          // ==================================================

          if (pengguna.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics:
                const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 250),

                  Center(
                    child: Text(
                      'Tidak ada data',
                    ),
                  ),
                ],
              ),
            );
          }

          // ==================================================
          // LIST DATA + REFRESH INDICATOR
          // ==================================================

          return RefreshIndicator(
            onRefresh: _refresh,

            child: ListView.builder(
              physics:
              const AlwaysScrollableScrollPhysics(),

              itemCount: pengguna.length,

              itemBuilder: (context, index) {
                final user = pengguna[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      user.name[0],
                    ),
                  ),

                  title: Text(
                    user.name,
                  ),

                  subtitle: Text(
                    '@${user.username}',
                  ),

                  trailing: const Icon(
                    Icons.chevron_right,
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailPenggunaPage(
                            pengguna: user,
                          );
                        },
                      ),
                    );
                  },
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
// DETAIL PENGGUNA
// ======================================================

class DetailPenggunaPage extends StatelessWidget {
  final Pengguna pengguna;

  const DetailPenggunaPage({
    super.key,
    required this.pengguna,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pengguna.name,
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          // NAMA
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Nama'),
            subtitle: Text(
              pengguna.name,
            ),
          ),

          // USERNAME
          ListTile(
            leading: const Icon(
              Icons.account_circle,
            ),
            title: const Text('Username'),
            subtitle: Text(
              pengguna.username,
            ),
          ),

          // EMAIL
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(
              pengguna.email,
            ),
          ),

          // TELEPON
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Telepon'),
            subtitle: Text(
              pengguna.phone,
            ),
          ),

          // WEBSITE
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Website'),
            subtitle: Text(
              pengguna.website,
            ),
          ),

          // KOTA
          ListTile(
            leading: const Icon(
              Icons.location_city,
            ),
            title: const Text('Kota'),
            subtitle: Text(
              pengguna.city,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// MAIN
// ======================================================

void main() {
  runApp(
    const MyApp(),
  );
}

// ======================================================
// MY APP
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Latihan Mandiri Pertemuan 4',

      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      home: const PenggunaPage(),
    );
  }
}