import 'package:flutter/material.dart';

// ======================================================
// TEMA
// ======================================================

final themeMode = ValueNotifier<ThemeMode>(
  ThemeMode.light,
);

final seedColor = ValueNotifier<Color>(
  Colors.indigo,
);

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

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
// MEMBUAT TEMA
// ======================================================

ThemeData buatTema(
    Color seed,
    Brightness brightness,
    ) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}

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
    return ListenableBuilder(
      listenable: Listenable.merge([
        themeMode,
        seedColor,
      ]),
      builder: (context, child) {
        return MaterialApp(
          title: 'Praktikum 6D',
          debugShowCheckedModeBanner: false,

          theme: buatTema(
            seedColor.value,
            Brightness.light,
          ),

          darkTheme: buatTema(
            seedColor.value,
            Brightness.dark,
          ),

          themeMode: themeMode.value,

          // ROUTE UTAMA
          initialRoute: '/',

          routes: {
            '/': (context) => const ShellPage(),
          },

          // ROUTE DETAIL
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
      },
    );
  }
}

// ======================================================
// SHELL PAGE
// ======================================================

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  // Halaman yang akan ditampilkan
  static const _halaman = [
    BerandaTab(),
    AnimasiTab(),
    PengaturanTab(),
  ];

  // Judul AppBar
  static const _judul = [
    'Beranda',
    'Animasi',
    'Pengaturan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _judul[_index],
        ),
      ),

      // ==================================================
      // INDEXED STACK
      // ==================================================

      body: IndexedStack(
        index: _index,
        children: _halaman,
      ),

      // ==================================================
      // NAVIGATION BAR
      // ==================================================

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

// ======================================================
// BERANDA TAB
// ======================================================

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daftarItem.length,

      itemBuilder: (context, index) {
        final item = daftarItem[index];

        return Card(
          margin: const EdgeInsets.only(
            bottom: 12,
          ),

          child: ListTile(
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

            title: Text(
              item.nama,
              style: tema.textTheme.titleMedium,
            ),

            subtitle: const Text(
              'Tekan untuk melihat detail',
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),

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
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

            Text(
              item.nama,
              style: tema.textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            Text(
              'Ini adalah halaman detail ${item.nama}.',
              style: tema.textTheme.bodyLarge,
            ),

            const SizedBox(height: 24),

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

// ======================================================
// ANIMASI TAB
// ======================================================

class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;

  int _hitung = 0;

  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    _putar = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    )..repeat();
  }

  @override
  void dispose() {
    _putar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),

      children: [
        // ==================================================
        // ANIMATED CONTAINER
        // ==================================================

        Text(
          'AnimatedContainer',
          style: tema.textTheme.titleLarge,
        ),

        const SizedBox(height: 16),

        Center(
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 500,
            ),

            width: _besar ? 220 : 120,

            height: _besar ? 220 : 120,

            decoration: BoxDecoration(
              color: _besar
                  ? tema.colorScheme.primary
                  : tema.colorScheme.secondary,

              borderRadius: BorderRadius.circular(
                _besar ? 40 : 12,
              ),
            ),

            child: Icon(
              Icons.flutter_dash,
              size: _besar ? 90 : 60,
              color: tema.colorScheme.onPrimary,
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

          child: const Text(
            'Ubah Ukuran',
          ),
        ),

        const SizedBox(height: 32),

        // ==================================================
        // ANIMATED SWITCHER
        // ==================================================

        Text(
          'AnimatedSwitcher',
          style: tema.textTheme.titleLarge,
        ),

        const SizedBox(height: 16),

        Center(
          child: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 500,
            ),

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
              key: ValueKey(_hitung),
              style: tema.textTheme.displayLarge,
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

          child: const Text(
            'Tambah',
          ),
        ),

        const SizedBox(height: 32),

        // ==================================================
        // ROTATION TRANSITION
        // ==================================================

        Text(
          'RotationTransition',
          style: tema.textTheme.titleLarge,
        ),

        const SizedBox(height: 24),

        Center(
          child: RotationTransition(
            turns: _putar,

            child: Icon(
              Icons.settings,
              size: 100,
              color: tema.colorScheme.primary,
            ),
          ),
        ),

        const SizedBox(height: 24),

        FilledButton(
          onPressed: () {
            if (_putar.isAnimating) {
              _putar.stop();
            } else {
              _putar.repeat();
            }

            setState(() {});
          },

          child: Text(
            _putar.isAnimating
                ? 'Berhenti'
                : 'Putar Lagi',
          ),
        ),
      ],
    );
  }
}

// ======================================================
// PENGATURAN TAB
// ======================================================

class PengaturanTab extends StatelessWidget {
  const PengaturanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        themeMode,
        seedColor,
      ]),

      builder: (context, child) {
        return ListView(
          padding: const EdgeInsets.all(16),

          children: [
            // ==================================================
            // MODE GELAP
            // ==================================================

            SwitchListTile(
              title: const Text(
                'Mode gelap',
              ),

              value: themeMode.value == ThemeMode.dark,

              onChanged: (value) {
                themeMode.value = value
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),

            const SizedBox(height: 16),

            // ==================================================
            // WARNA TEMA
            // ==================================================

            Text(
              'Warna tema',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,

              children: [
                for (final warna in pilihanWarna)
                  GestureDetector(
                    onTap: () {
                      seedColor.value = warna;
                    },

                    child: CircleAvatar(
                      backgroundColor: warna,

                      child: seedColor.value == warna
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}