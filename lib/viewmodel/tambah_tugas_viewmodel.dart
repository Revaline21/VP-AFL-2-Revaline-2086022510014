import 'package:flutter/foundation.dart';

import '../model/domain/clock.dart';
import '../model/domain/tugas.dart';
import '../model/domain/tugas_repository.dart';
import 'tambah_tugas_state.dart';

class TambahTugasViewModel extends ChangeNotifier {
  final TugasRepository _repo;
  final Clock _clock;

  TambahTugasState _state = const FormIdle();
  DateTime? _tanggal;
  int? _jam;
  int? _menit;
  bool _disposed = false;

  TambahTugasViewModel(this._repo, {this._clock = const Clock()});

  TambahTugasState get state => _state;
  DateTime? get tanggal => _tanggal;
  int? get jam => _jam;
  int? get menit => _menit;
  DateTime? get deadline {
    if (_tanggal == null || _jam == null || _menit == null) return null;
    return DateTime(
      _tanggal!.year,
      _tanggal!.month,
      _tanggal!.day,
      _jam!,
      _menit!,
    );
  }

  void pilihTanggal(DateTime tanggal) {
    _tanggal = DateTime(tanggal.year, tanggal.month, tanggal.day);
    _beritahu();
  }

  void pilihWaktu({required int jam, required int menit}) {
    _jam = jam;
    _menit = menit;
    _beritahu();
  }

  void reset() {
    _tanggal = null;
    _jam = null;
    _menit = null;
    _state = const FormIdle();
    _beritahu();
  }

  Future<void> simpan(String nama) async {
    if (_state is FormSaving) return;

    final namaBersih = nama.trim();
    if (namaBersih.isEmpty) {
      _setState(const FormFailure('Nama tugas tidak boleh kosong'));
      return;
    }

    final batas = deadline;
    if (batas == null) {
      _setState(
        const FormFailure('Tanggal dan waktu pengumpulan harus dipilih'),
      );
      return;
    }

    final sekarang = _clock.sekarang();
    if (batas.isBefore(sekarang)) {
      _setState(const FormFailure('Deadline tidak boleh di masa lalu'));
      return;
    }

    _setState(const FormSaving());
    try {
      await _repo.tambah(
        Tugas(
          id: sekarang.microsecondsSinceEpoch.toString(),
          nama: namaBersih,
          deadline: batas,
        ),
      );
      if (_disposed) return;
      _setState(const FormSuccess());
    } catch (e) {
      debugPrint('simpan gagal: $e');
      if (_disposed) return;
      _setState(const FormFailure('Gagal menyimpan tugas, coba lagi.'));
    }
  }

  void _setState(TambahTugasState baru) {
    _state = baru;
    _beritahu();
  }

  void _beritahu() {
    if (_disposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}