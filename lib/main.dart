import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'model/data/repository/tugas_repository_impl.dart';
import 'model/data/service/tugas_local_service.dart';
import 'model/data/service/tugas_service.dart';
import 'model/domain/tugas_repository.dart';
import 'viewmodel/daftar_tugas_viewmodel.dart';
import 'viewmodel/tambah_tugas_viewmodel.dart';
import 'views/screen/daftar_tugas_screen.dart';

void main() {
  runApp(const SatgasApp());
}

TugasRepository buatRepository() {
  final TugasService service = TugasLocalService();
  return TugasRepositoryImpl(service);
}

class SatgasApp extends StatefulWidget {
  final TugasRepository? repository;

  const SatgasApp({super.key, this.repository});

  @override
  State<SatgasApp> createState() => _SatgasAppState();
}

class _SatgasAppState extends State<SatgasApp> {
  late final DaftarTugasViewModel _daftarVm;
  late final TambahTugasViewModel _tambahVm;

  @override
  void initState() {
    super.initState();
    final repo = widget.repository ?? buatRepository();
    _daftarVm = DaftarTugasViewModel(repo);
    _tambahVm = TambahTugasViewModel(repo);
  }

  @override
  void dispose() {
    _daftarVm.dispose();
    _tambahVm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SATGAS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.terang(),
      darkTheme: AppTheme.gelap(),
      themeMode: ThemeMode.system,
      home: DaftarTugasScreen(
        viewModel: _daftarVm,
        tambahViewModel: _tambahVm,
      ),
    );
  }
}