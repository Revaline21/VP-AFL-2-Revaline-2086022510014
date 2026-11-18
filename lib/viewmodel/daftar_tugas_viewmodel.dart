import 'package:flutter/foundation.dart';

import '../model/domain/clock.dart';
import '../model/domain/tugas.dart';
import '../model/domain/tugas_repository.dart';
import 'daftar_tugas_state.dart';


class DaftarTugasViewModel extends ChangeNotifier {
  final TugasRepository _repo;
  final Clock _clock;

  DaftarTugasState _state = const TugasLoading();
  bool _disposed = false;

  DaftarTugasViewModel(this._repo, {this._clock = const Clock()});
  DaftarTugasState get state => _state;

  Future<void> muat({bool tampilkanLoading = true}) async {
    if (tampilkanLoading) _setState(const TugasLoading());
    try {
      final daftar = await _repo.ambilSemua();
      if (_disposed) return;
      _setState(
        daftar.isEmpty ? const TugasEmpty() : TugasLoaded(_urutkan(daftar)),
      );
    } catch (e) {
      debugPrint('muat gagal: $e');
      if (_disposed) return;
      _setState(const TugasError('Gagal memuat daftar tugas, coba lagi.'));
    }
  }

  Future<void> ubahSelesai(String id, bool selesai) async {
    try {
      await _repo.ubahSelesai(id, selesai);
      if (_disposed) return;
      await muat(tampilkanLoading: false);
    } catch (e) {
      debugPrint('ubahSelesai gagal: $e');
      if (_disposed) return;
      _setState(const TugasError('Gagal mengubah status tugas, coba lagi.'));
    }
  }

  Future<void> hapus(String id) async {
    try {
      await _repo.hapus(id);
      if (_disposed) return;
      await muat(tampilkanLoading: false);
    } catch (e) {
      debugPrint('hapus gagal: $e');
      if (_disposed) return;
      _setState(const TugasError('Gagal menghapus tugas, coba lagi.'));
    }
  }

  bool terlambat(Tugas tugas) =>
      !tugas.selesai && tugas.deadline.isBefore(_clock.sekarang());

  List<Tugas> _urutkan(List<Tugas> daftar) =>
      List.of(daftar)..sort((a, b) => a.deadline.compareTo(b.deadline));

  void _setState(DaftarTugasState baru) {
    if (_disposed) return;
    _state = baru;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}