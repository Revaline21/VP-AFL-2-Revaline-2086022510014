import 'package:flutter/material.dart';

class TugasErrorView extends StatelessWidget {
  final String pesan;
  final VoidCallback onCobaLagi;

  const TugasErrorView({
    super.key,
    required this.pesan,
    required this.onCobaLagi,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 72, color: tema.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              pesan,
              style: tema.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onCobaLagi, child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }
}