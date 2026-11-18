import 'package:equatable/equatable.dart';
sealed class TambahTugasState extends Equatable {
  const TambahTugasState();

  @override
  List<Object?> get props => [];
}

class FormIdle extends TambahTugasState {
  const FormIdle();
}

class FormSaving extends TambahTugasState {
  const FormSaving();
}

class FormSuccess extends TambahTugasState {
  const FormSuccess();
}
class FormFailure extends TambahTugasState {
  final String pesan;

  const FormFailure(this.pesan);

  @override
  List<Object?> get props => [pesan];
}