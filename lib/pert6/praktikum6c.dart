import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 6C',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),

      home: const AnimasiTab(),
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

  // Untuk AnimatedContainer
  bool _besar = false;

  // Untuk AnimatedSwitcher
  int _hitung = 0;

  // Untuk AnimationController
  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animasi'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // ==================================================
          // ANIMATED CONTAINER
          // ==================================================

          Text(
            '1. AnimatedContainer',
            style: tema.textTheme.titleLarge,
          ),

          const SizedBox(height: 12),

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

              child: Center(
                child: Icon(
                  Icons.flutter_dash,
                  size: _besar ? 90 : 60,
                  color: tema.colorScheme.onPrimary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

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
            '2. AnimatedSwitcher',
            style: tema.textTheme.titleLarge,
          ),

          const SizedBox(height: 12),

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

          const SizedBox(height: 12),

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
            '3. RotationTransition',
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
      ),
    );
  }
}