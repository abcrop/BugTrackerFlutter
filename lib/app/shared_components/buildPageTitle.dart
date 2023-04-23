import 'package:flutter/cupertino.dart';

import '../constants/app_constants.dart';

class BuildPageTitle extends StatelessWidget{
  const BuildPageTitle({Key? key, required this.label, required this.iconData}) : super(key: key);

  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return _buildPageTitle();
  }


  Widget _buildPageTitle() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(width: kSpacing / 2),
          _buildLabel(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      iconData,
      size: 20,
      color: kFontColorPallets[1]
    );
  }

  Widget _buildLabel() {
    return Text(
      label,
      style: TextStyle(
        color: kFontColorPallets[1],
        fontWeight: FontWeight.bold,
        letterSpacing: .8,
        fontSize: 17,
      ),
    );
  }


}