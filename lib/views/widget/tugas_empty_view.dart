import 'package:flutter/material.dart';

class TugasEmptyView extends StatelessWidget {
  const TugasEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt, size: 72, color: tema.colorScheme.outline),
            const SizedBox(height: 16),
            Text('Belum ada tugas', style: tema.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Ketuk tombol + untuk menambah tugas.',
              style: tema.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}