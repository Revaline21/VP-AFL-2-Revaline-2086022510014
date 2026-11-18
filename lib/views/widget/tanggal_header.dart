import 'package:flutter/material.dart';

const _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
const _bulan = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

class TanggalHeader extends StatelessWidget {
  final DateTime tanggal;

  const TanggalHeader({super.key, required this.tanggal});

  @override
  Widget build(BuildContext context) {
    final teks = '${_hari[tanggal.weekday - 1]}, ${tanggal.day} '
        '${_bulan[tanggal.month - 1]} ${tanggal.year}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        teks,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}