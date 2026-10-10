import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ============================================================
// DATA TEMA
// ============================================================

final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
final seedColor = ValueNotifier<Color>(Colors.indigo);

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

// ============================================================
// MODEL PRODUK
// ============================================================

class Produk {
  final String nama;
  final String deskripsi;
  final double harga;
  final IconData ikon;

  const Produk({
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.ikon,
  });
}

// ============================================================
// DATA PRODUK
// ============================================================

const daftarProduk = [
  Produk(
    nama: 'Laptop',
    deskripsi: 'Laptop untuk kebutuhan belajar, kerja, dan aktivitas sehari-hari.',
    harga: 7500000,
    ikon: Icons.laptop,
  ),
  Produk(
    nama: 'Headphone',
    deskripsi: 'Headphone dengan suara jernih untuk musik dan hiburan.',
    harga: 850000,
    ikon: Icons.headphones,
  ),
  Produk(
    nama: 'Kamera',
    deskripsi: 'Kamera untuk mengabadikan foto dan video berkualitas.',
    harga: 5200000,
    ikon: Icons.camera_alt,
  ),
  Produk(
    nama: 'Smartphone',
    deskripsi: 'Smartphone untuk komunikasi, belajar, dan kebutuhan digital.',
    harga: 4500000,
    ikon: Icons.smartphone,
  ),
];

// ============================================================
// FUNGSI TEMA
// ============================================================

ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}

// ============================================================
// MAIN
// ============================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // Membaca mode gelap
  final modeGelap = prefs.getBool('modeGelap') ?? false;

  // Membaca warna tema
  final warnaIndex = prefs.getInt('warnaIndex') ?? 0;

  themeMode.value =
  modeGelap ? ThemeMode.dark : ThemeMode.light;

  seedColor.value = pilihanWarna[warnaIndex];

  runApp(const MyApp());
}

// ============================================================
// MY APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        themeMode,
        seedColor,
      ]),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Galeri Produk',

          theme: buatTema(
            seedColor.value,
            Brightness.light,
          ),

          darkTheme: buatTema(
            seedColor.value,
            Brightness.dark,
          ),

          themeMode: themeMode.value,

          initialRoute: '/',

          routes: {
            '/': (context) => const ShellPage(),
          },

          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final produk = settings.arguments as Produk;

              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    ) {
                  return DetailProdukPage(
                    produk: produk,
                  );
                },
                transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                    ) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }

            return null;
          },

          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const Halaman404(),
            );
          },
        );
      },
    );
  }
}

// ============================================================
// SHELL PAGE
// ============================================================

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  final List<Widget> _halaman = const [
    BerandaTab(),
    AnimasiTab(),
    PengaturanTab(),
  ];

  final List<String> _judul = const [
    'Galeri Produk',
    'Animasi',
    'Pengaturan',
  ];

  void pindahTab(int index) {
    setState(() {
      _index = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_index]),
      ),

      // ======================================================
      // DRAWER
      // ======================================================

      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.storefront,
                      size: 50,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Galeri Produk',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Beranda'),
                selected: _index == 0,
                onTap: () => pindahTab(0),
              ),

              ListTile(
                leading: const Icon(Icons.animation),
                title: const Text('Animasi'),
                selected: _index == 1,
                onTap: () => pindahTab(1),
              ),

              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Pengaturan'),
                selected: _index == 2,
                onTap: () => pindahTab(2),
              ),
            ],
          ),
        ),
      ),

      // ======================================================
      // INDEXED STACK
      // ======================================================

      body: IndexedStack(
        index: _index,
        children: _halaman,
      ),

      // ======================================================
      // NAVIGATION BAR
      // ======================================================

      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.animation_outlined),
            selectedIcon: Icon(Icons.animation),
            label: 'Animasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TAB BERANDA
// ============================================================

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final warnaUtama =
        Theme.of(context).colorScheme.primary;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daftarProduk.length,
      itemBuilder: (context, index) {
        final produk = daftarProduk[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),

            leading: Hero(
              tag: 'produk-${produk.nama}',
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                child: Icon(
                  produk.ikon,
                  color: warnaUtama,
                  size: 30,
                ),
              ),
            ),

            title: Text(
              produk.nama,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Rp ${produk.harga.toStringAsFixed(0)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),

            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: produk,
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// DETAIL PRODUK
// ============================================================

class DetailProdukPage extends StatelessWidget {
  final Produk produk;

  const DetailProdukPage({
    super.key,
    required this.produk,
  });

  @override
  Widget build(BuildContext context) {
    final warnaUtama =
        Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(produk.nama),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              // HERO
              Hero(
                tag: 'produk-${produk.nama}',
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: Icon(
                    produk.ikon,
                    size: 80,
                    color: warnaUtama,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                produk.nama,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),

              const SizedBox(height: 12),

              Text(
                produk.deskripsi,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      Text(
                        'Harga',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Rp ${produk.harga.toStringAsFixed(0)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TAB ANIMASI
// ============================================================

class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;
  bool _tampil = true;

  int _hitung = 0;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warnaUtama =
        Theme.of(context).colorScheme.primary;

    return ListView(
      padding: const EdgeInsets.all(20),

      children: [
        // ====================================================
        // ANIMATED CONTAINER
        // ====================================================

        Text(
          '1. AnimatedContainer',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(height: 12),

        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _besar ? 220 : 120,
            height: _besar ? 220 : 120,
            decoration: BoxDecoration(
              color: _besar
                  ? Theme.of(context)
                  .colorScheme
                  .primary
                  : Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              borderRadius: BorderRadius.circular(
                _besar ? 50 : 15,
              ),
            ),

            child: Icon(
              Icons.shopping_bag,
              size: _besar ? 90 : 50,
              color: _besar
                  ? Theme.of(context)
                  .colorScheme
                  .onPrimary
                  : warnaUtama,
            ),
          ),
        ),

        const SizedBox(height: 16),

        FilledButton(
          onPressed: () {
            setState(() {
              _besar = !_besar;
            });
          },
          child: const Text('Ubah Ukuran'),
        ),

        const Divider(height: 40),

        // ====================================================
        // ANIMATED SWITCHER
        // ====================================================

        Text(
          '2. AnimatedSwitcher',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(height: 16),

        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),

            transitionBuilder: (
                child,
                animation,
                ) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },

            child: Text(
              '$_hitung',
              key: ValueKey<int>(_hitung),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium,
            ),
          ),
        ),

        const SizedBox(height: 16),

        FilledButton(
          onPressed: () {
            setState(() {
              _hitung++;
            });
          },
          child: const Text('Tambah Angka'),
        ),

        const Divider(height: 40),

        // ====================================================
        // ANIMATION CONTROLLER
        // ====================================================

        Text(
          '3. RotationTransition',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(height: 20),

        Center(
          child: RotationTransition(
            turns: _controller,
            child: Icon(
              Icons.settings,
              size: 100,
              color: warnaUtama,
            ),
          ),
        ),

        const SizedBox(height: 20),

        FilledButton(
          onPressed: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.repeat();
            }

            setState(() {});
          },
          child: Text(
            _controller.isAnimating
                ? 'Hentikan Animasi'
                : 'Jalankan Animasi',
          ),
        ),

        const Divider(height: 40),

        // ====================================================
        // ANIMATED OPACITY
        // ====================================================

        Text(
          '4. AnimatedOpacity',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(height: 16),

        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _tampil ? 1.0 : 0.0,

          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(30),

              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.star,
                      size: 60,
                      color: warnaUtama,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Kartu Animasi',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        FilledButton(
          onPressed: () {
            setState(() {
              _tampil = !_tampil;
            });
          },
          child: Text(
            _tampil
                ? 'Sembunyikan Kartu'
                : 'Tampilkan Kartu',
          ),
        ),
      ],
    );
  }
}

// ============================================================
// TAB PENGATURAN
// ============================================================

class PengaturanTab extends StatelessWidget {
  const PengaturanTab({super.key});

  Future<void> simpanMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'modeGelap',
      value,
    );

    themeMode.value =
    value ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> simpanWarna(
      int index,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      'warnaIndex',
      index,
    );

    seedColor.value = pilihanWarna[index];
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        themeMode,
        seedColor,
      ]),

      builder: (context, child) {
        return ListView(
          padding: const EdgeInsets.all(20),

          children: [
            // =================================================
            // MODE GELAP
            // =================================================

            Card(
              child: SwitchListTile(
                title: const Text(
                  'Mode Gelap',
                ),

                subtitle: const Text(
                  'Ubah tampilan menjadi mode gelap',
                ),

                value:
                themeMode.value == ThemeMode.dark,

                onChanged: (value) {
                  simpanMode(value);
                },
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // PILIHAN WARNA
            // =================================================

            Text(
              'Warna Tema',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),

            const SizedBox(height: 12),

            Text(
              'Pilih warna utama aplikasi:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              runSpacing: 12,

              children: [
                for (
                int i = 0;
                i < pilihanWarna.length;
                i++
                )
                  GestureDetector(
                    onTap: () {
                      simpanWarna(i);
                    },

                    child: CircleAvatar(
                      radius: 30,

                      backgroundColor:
                      pilihanWarna[i],

                      child:
                      seedColor.value ==
                          pilihanWarna[i]
                          ? Icon(
                        Icons.check,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary,
                      )
                          : null,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 30),

            // =================================================
            // INFO
            // =================================================

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    Icon(
                      Icons.palette,
                      size: 50,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Tema Tersimpan',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Mode dan warna tema akan tetap tersimpan setelah aplikasi ditutup.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// HALAMAN 404
// ============================================================

class Halaman404 extends StatelessWidget {
  const Halaman404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tidak Ditemukan'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Theme.of(context)
                  .colorScheme
                  .error,
            ),

            const SizedBox(height: 16),

            Text(
              '404',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium,
            ),

            const SizedBox(height: 8),

            Text(
              'Halaman tidak ditemukan',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                      (route) => false,
                );
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}