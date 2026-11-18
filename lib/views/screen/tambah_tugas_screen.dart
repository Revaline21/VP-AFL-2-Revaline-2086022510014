import 'package:flutter/material.dart';

import '../../viewmodel/tambah_tugas_state.dart';
import '../../viewmodel/tambah_tugas_viewmodel.dart';
import '../widget/tanggal_waktu.dart';

String _formatTanggal(DateTime t) =>
    '${t.day.toString().padLeft(2, '0')}/'
    '${t.month.toString().padLeft(2, '0')}/${t.year}';

String _formatWaktu(int jam, int menit) =>
    '${jam.toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')}';

class TambahTugasScreen extends StatefulWidget {
  final TambahTugasViewModel viewModel;

  const TambahTugasScreen({super.key, required this.viewModel});

  @override
  State<TambahTugasScreen> createState() => _TambahTugasScreenState();
}

class _TambahTugasScreenState extends State<TambahTugasScreen> {
  // Hanya untuk teks yang sedang diketik; wajib di-dispose.
  final _namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_pantauState);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_pantauState);
    _namaController.dispose();
    super.dispose();
  }

  /// Kembali ke daftar begitu penyimpanan berhasil.
  void _pantauState() {
    if (!mounted) return;
    if (widget.viewModel.state is FormSuccess) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _pilihTanggal() async {
    final vm = widget.viewModel;
    final sekarang = DateTime.now();
    final hasil = await showDatePicker(
      context: context,
      initialDate: vm.tanggal ?? sekarang,
      firstDate: DateTime(sekarang.year, sekarang.month, sekarang.day),
      lastDate: DateTime(sekarang.year + 5),
    );
    if (hasil != null) vm.pilihTanggal(hasil);
  }

  Future<void> _pilihWaktu() async {
    final vm = widget.viewModel;
    final awal = vm.jam != null && vm.menit != null
        ? TimeOfDay(hour: vm.jam!, minute: vm.menit!)
        : TimeOfDay.now();
    final hasil = await showTimePicker(context: context, initialTime: awal);
    if (hasil != null) vm.pilihWaktu(jam: hasil.hour, menit: hasil.minute);
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, _) {
          final state = vm.state;
          final menyimpan = state is FormSaving;
          final pesanError = switch (state) {
            FormFailure(:final pesan) => pesan,
            FormIdle() || FormSaving() || FormSuccess() => null,
          };

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _namaController,
                enabled: !menyimpan,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nama tugas',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TanggalWaktuField(
                label: 'Tanggal',
                nilai: vm.tanggal == null ? null : _formatTanggal(vm.tanggal!),
                ikon: Icons.calendar_today,
                onTap: _pilihTanggal,
              ),
              const SizedBox(height: 16),
              TanggalWaktuField(
                label: 'Waktu',
                nilai: vm.jam == null || vm.menit == null
                    ? null
                    : _formatWaktu(vm.jam!, vm.menit!),
                ikon: Icons.access_time,
                onTap: _pilihWaktu,
              ),
              if (pesanError != null) ...[
                const SizedBox(height: 16),
                Text(
                  pesanError,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed:
                    menyimpan ? null : () => vm.simpan(_namaController.text),
                child: menyimpan
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan'),
              ),
            ],
          );
        },
      ),
    );
  }
}