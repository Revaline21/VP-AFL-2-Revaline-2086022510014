import 'package:flutter/material.dart';

import '../../viewmodel/daftar_tugas_state.dart';
import '../../viewmodel/daftar_tugas_viewmodel.dart';
import '../../viewmodel/tambah_tugas_viewmodel.dart';
import '../widget/tugas_empty_view.dart';
import '../widget/tugas_error_view.dart';
import '../widget/tugas_loaded_view.dart';
import '../widget/tugas_loading_view.dart';
import 'tambah_tugas_screen.dart';

class DaftarTugasScreen extends StatefulWidget {
    final DaftarTugasViewModel viewModel;
    final TambahTugasViewModel tambahViewModel;
    
    const DaftarTugasScreen({
        super.key,
        required this.viewModel,
        required this.tambahViewModel,
        });
        
        @override
        State<DaftarTugasScreen> createState() => _DaftarTugasScreenState();
    }

class _DaftarTugasScreenState extends State<DaftarTugasScreen> {
    @override
    void initState() {
        super.initState();
        widget.viewModel.muat();
    }
    
    Future<void> _bukaForm() async {
        widget.tambahViewModel.reset();
        final tersimpan = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
                builder: (_) => TambahTugasScreen(viewModel: widget.tambahViewModel),
            ),
        );
        
        if (!mounted) return;
        if (tersimpan == true) {
            await widget.viewModel.muat(tampilkanLoading: false);
        }
    }
    
    @override
    Widget build(BuildContext context) {
        final vm = widget.viewModel;
        return Scaffold(
        appBar: AppBar(title: const Text('SATGAS')),
        body: ListenableBuilder(
        listenable: vm,
        builder: (context, _) {
            return switch (vm.state) {
                TugasLoading() => const TugasLoadingView(),
                TugasEmpty() => const TugasEmptyView(),
                TugasLoaded(:final daftar) => TugasLoadedView(
                    daftar: daftar,
                    terlambat: vm.terlambat,
                    onUbahSelesai: vm.ubahSelesai,
                    onHapus: vm.hapus,
                ),
                TugasError(:final pesan) => TugasErrorView(
                    pesan: pesan,
                    onCobaLagi: vm.muat,
                ),
            };
        },
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: _bukaForm,
        tooltip: 'Tambah tugas',
        child: const Icon(Icons.add),
    ),
);
}
}