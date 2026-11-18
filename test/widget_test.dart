import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satgas_saatnya_tugas/main.dart';
import 'package:satgas_saatnya_tugas/model/data/repository/tugas_repository_impl.dart';
import 'package:satgas_saatnya_tugas/model/data/service/tugas_local_service.dart';

void main() {
  testWidgets('app terbuka di daftar kosong dan bisa membuka form', (
    tester,
  ) async {
    final repo = TugasRepositoryImpl(TugasLocalService());

    await tester.pumpWidget(SatgasApp(repository: repo));
    await tester.pumpAndSettle();

    expect(find.text('Belum ada tugas'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Tambah Tugas'), findsOneWidget);
  });
}