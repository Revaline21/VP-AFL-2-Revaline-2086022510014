import 'package:equatable/equatable.dart';


class Tugas extends Equatable {
  final String id;
  final String nama;
  final DateTime deadline;
  final bool selesai;

  const Tugas({
    required this.id,
    required this.nama,
    required this.deadline,
    this.selesai = false,
  });


  Tugas copyWith({String? nama, DateTime? deadline, bool? selesai}) {
    return Tugas(
      id: id,
      nama: nama ?? this.nama,
      deadline: deadline ?? this.deadline,
      selesai: selesai ?? this.selesai,
    );
  }

  @override
  List<Object?> get props => [id, nama, deadline, selesai];
}