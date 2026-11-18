import 'package:flutter/material.dart';

class TanggalWaktuField extends StatelessWidget {
  final String label;
  final String? nilai;
  final IconData ikon;
  final VoidCallback onTap;

  const TanggalWaktuField({
    super.key,
    required this.label,
    required this.nilai,
    required this.ikon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: Icon(ikon),
        ),
        child: Text(
          nilai ?? 'Pilih $label',
          style: nilai == null
              ? tema.textTheme.bodyLarge?.copyWith(color: tema.hintColor)
              : tema.textTheme.bodyLarge,
        ),
      ),
    );
  }
}