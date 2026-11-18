import 'package:flutter/material.dart';

import '../../model/domain/tugas.dart';
import 'status_label.dart';

class TugasItem extends StatelessWidget {
  final Tugas tugas;
  final bool terlambat;
  final ValueChanged<bool> onUbahSelesai;
  final VoidCallback onHapus;

  const TugasItem({
    super.key,
    required this.tugas,
    required this.terlambat,
    required this.onUbahSelesai,
    required this.onHapus,
  });

  String get _jam {
    final j = tugas.deadline.hour.toString().padLeft(2, '0');
    final m = tugas.deadline.minute.toString().padLeft(2, '0');
    return '$j:$m';
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: terlambat ? skema.errorContainer : null,
      child: ListTile(
        leading: Checkbox(
          value: tugas.selesai,
          onChanged: (nilai) => onUbahSelesai(nilai ?? false),
        ),
        title: Text(
          tugas.nama,
          style: TextStyle(
            decoration: tugas.selesai ? TextDecoration.lineThrough : null,
            color: terlambat ? skema.onErrorContainer : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Text(_jam),
              const SizedBox(width: 8),
              StatusLabel(selesai: tugas.selesai, terlambat: terlambat),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Hapus tugas',
          onPressed: onHapus,
        ),
      ),
    );
  }
}