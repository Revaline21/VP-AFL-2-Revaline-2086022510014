import '../../domain/tugas.dart';

abstract class TugasService {
  Future<List<Tugas>> ambilSemua();
  Future<void> simpan(Tugas tugas);
  Future<void> ubahSelesai(String id, bool selesai);
  Future<void> hapus(String id);
}
