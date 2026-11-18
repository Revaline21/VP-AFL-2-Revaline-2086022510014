import 'package:flutter/material.dart';
class TugasLoadingView extends StatelessWidget {
  const TugasLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}