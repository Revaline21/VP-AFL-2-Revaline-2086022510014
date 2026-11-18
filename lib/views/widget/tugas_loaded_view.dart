import 'package:flutter/material.dart';

import '../../model/domain/tugas.dart';
import 'tanggal_header.dart';
import 'tugas_item.dart';

class TugasLoadedView extends StatelessWidget {
  final List<Tugas> daftar;
  final bool Function(Tugas) terlambat;
  final void Function(String id, bool selesai) onUbahSelesai;
  final void Function(String id) onHapus;

  const TugasLoadedView({
    super.key,
    required this.daftar,
    required this.terlambat,
    required this.onUbahSelesai,
    required this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    final baris = <Object>[];
    DateTime? hariTerakhir;
    for (final tugas in daftar) {
      final d = tugas.deadline;
      final hari = DateTime(d.year, d.month, d.day);
      if (hari != hariTerakhir) {
        baris.add(hari);
        hariTerakhir = hari;
      }
      baris.add(tugas);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: baris.length,
      itemBuilder: (context, i) {
        final isi = baris[i];
        if (isi is DateTime) return TanggalHeader(tanggal: isi);

        final tugas = isi as Tugas;
        return TugasItem(
          tugas: tugas,
          terlambat: terlambat(tugas),
          onUbahSelesai: (selesai) => onUbahSelesai(tugas.id, selesai),
          onHapus: () => onHapus(tugas.id),
        );
      },
    );
  }
}