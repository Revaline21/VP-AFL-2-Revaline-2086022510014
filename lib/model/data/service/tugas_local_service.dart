import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/tugas.dart';
import 'tugas_service.dart';

class TugasLocalService implements TugasService {
  static const _kunci = 'daftar_tugas';

  Future<void> _antrian = Future.value();

  Future<T> _berurutan<T>(Future<T> Function() aksi) {
    final hasil = _antrian.then((_) => aksi());
    _antrian = hasil.then((_) {}, onError: (_) {});
    return hasil;
  }

  Future<List<Tugas>> _baca() async {
    final prefs = await SharedPreferences.getInstance();
    final teks = prefs.getString(_kunci);
    if (teks == null) return [];
    final daftar = jsonDecode(teks) as List<dynamic>;
    return daftar.map((e) => _dariMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> _tulis(List<Tugas> daftar) async {
    final prefs = await SharedPreferences.getInstance();
    final berhasil = await prefs.setString(
      _kunci,
      jsonEncode(daftar.map(_keMap).toList()),
    );
    if (!berhasil) throw StateError('Gagal menulis ke penyimpanan');
  }

  @override
  Future<List<Tugas>> ambilSemua() => _berurutan(() async {
        final daftar = await _baca();
        daftar.sort((a, b) => a.deadline.compareTo(b.deadline));
        return daftar;
      });

  @override
  Future<void> simpan(Tugas tugas) => _berurutan(() async {
        final daftar = await _baca();
        daftar.removeWhere((t) => t.id == tugas.id);
        daftar.add(tugas);
        await _tulis(daftar);
      });

  @override
  Future<void> ubahSelesai(String id, bool selesai) => _berurutan(() async {
        final daftar = await _baca();
        final index = daftar.indexWhere((t) => t.id == id);
        if (index == -1) {
          throw StateError('Tugas dengan id $id tidak ditemukan');
        }
        daftar[index] = daftar[index].copyWith(selesai: selesai);
        await _tulis(daftar);
      });

  @override
  Future<void> hapus(String id) => _berurutan(() async {
        final daftar = await _baca();
        daftar.removeWhere((t) => t.id == id);
        await _tulis(daftar);
      });

  Map<String, Object?> _keMap(Tugas t) => {
        'id': t.id,
        'nama': t.nama,
        'deadline': t.deadline.millisecondsSinceEpoch,
        'selesai': t.selesai,
      };

  Tugas _dariMap(Map<String, dynamic> m) => Tugas(
        id: m['id'] as String,
        nama: m['nama'] as String,
        deadline: DateTime.fromMillisecondsSinceEpoch(m['deadline'] as int),
        selesai: m['selesai'] as bool,
      );
}