import 'tugas.dart';

abstract class TugasRepository {
  Future<List<Tugas>> ambilSemua();
  Future<void> tambah(Tugas tugas);
  Future<void> ubahSelesai(String id, bool selesai);
  Future<void> hapus(String id);
}