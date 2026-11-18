import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color warnaDasar = Color(0xFF0EA5E9);

  static ThemeData terang() => _bangun(Brightness.light);

  static ThemeData gelap() => _bangun(Brightness.dark);

  static ThemeData _bangun(Brightness kecerahan) {
    final skema = ColorScheme.fromSeed(
      seedColor: warnaDasar,
      brightness: kecerahan,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: skema,
      appBarTheme: AppBarTheme(
        backgroundColor: skema.primaryContainer,
        foregroundColor: skema.onPrimaryContainer,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
