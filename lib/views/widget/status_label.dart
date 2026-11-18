import 'package:flutter/material.dart';

class StatusLabel extends StatelessWidget {
  final bool selesai;
  final bool terlambat;

  const StatusLabel({
    super.key,
    required this.selesai,
    required this.terlambat,
  });

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    final String teks;
    final Color latar;
    final Color tulisan;
    if (selesai) {
      teks = 'Selesai';
      latar = skema.primaryContainer;
      tulisan = skema.onPrimaryContainer;
    } else if (terlambat) {
      teks = 'Terlambat';
      latar = skema.error;
      tulisan = skema.onError;
    } else {
      teks = 'Belum';
      latar = skema.surfaceContainerHighest;
      tulisan = skema.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: latar,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        teks,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: tulisan),
      ),
    );
  }
}