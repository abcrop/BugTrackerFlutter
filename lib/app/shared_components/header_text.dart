import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(this.label, {Key? key}) : super(key: key);

  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
