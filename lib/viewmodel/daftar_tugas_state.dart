import 'package:equatable/equatable.dart';

import '../model/domain/tugas.dart';

sealed class DaftarTugasState extends Equatable {
  const DaftarTugasState();

  @override
  List<Object?> get props => [];
}

class TugasLoading extends DaftarTugasState {
  const TugasLoading();
}

class TugasEmpty extends DaftarTugasState {
  const TugasEmpty();
}

class TugasLoaded extends DaftarTugasState {
  final List<Tugas> daftar;

  const TugasLoaded(this.daftar);

  @override
  List<Object?> get props => [daftar];
}
class TugasError extends DaftarTugasState {
  final String pesan;

  const TugasError(this.pesan);

  @override
  List<Object?> get props => [pesan];
}