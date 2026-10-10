import 'package:flutter/material.dart';

// ======================================================
// PENGATURAN TEMA
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
          title: 'Praktikum 6A',
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

          home: Scaffold(
            appBar: AppBar(
              title: const Text('Tema'),
            ),
            body: const PengaturanTab(),
          ),
        );
      },
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
            // MODE GELAP
            SwitchListTile(
              title: const Text('Mode gelap'),

              value: themeMode.value == ThemeMode.dark,

              onChanged: (value) {
                themeMode.value = value
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),

            const SizedBox(height: 16),

            // JUDUL WARNA
            Text(
              'Warna tema',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 12),

            // PILIHAN WARNA
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