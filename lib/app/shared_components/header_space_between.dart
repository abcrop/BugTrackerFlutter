import 'package:flutter/material.dart';

import 'header_text.dart';

class HeaderSpaceBetweenData {
  final String headerText;
  final Widget? trailingWidget;

  const HeaderSpaceBetweenData({
    required this.headerText,
    this.trailingWidget,
  });
}

class HeaderSpaceBetween extends StatelessWidget {
  const HeaderSpaceBetween({required this.data, Key? key}) : super(key: key);

  final HeaderSpaceBetweenData data;

  @override
  Widget build(BuildContext context) {
    return _buildSpaceBetween(data);
  }

  Widget _buildSpaceBetween(HeaderSpaceBetweenData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: HeaderText(data.headerText),
        ),
        InkWell(
          onTap: () {},
          child: data.trailingWidget!,
        ),
      ],
    );
  }
}
