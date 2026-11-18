import '../../domain/tugas.dart';
import '../../domain/tugas_repository.dart';
import '../service/tugas_service.dart';

class TugasRepositoryImpl implements TugasRepository {
  final TugasService _service;

  TugasRepositoryImpl(this._service);

  @override
  Future<List<Tugas>> ambilSemua() => _service.ambilSemua();

  @override
  Future<void> tambah(Tugas tugas) => _service.simpan(tugas);

  @override
  Future<void> ubahSelesai(String id, bool selesai) =>
      _service.ubahSelesai(id, selesai);

  @override
  Future<void> hapus(String id) => _service.hapus(id);
}