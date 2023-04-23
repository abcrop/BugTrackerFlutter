import 'package:daily_task/app/utils/helpers/app_helpers.dart';
import 'package:flutter/material.dart';

class CircleLogoData {
  final HeightWidth? size;
  final String? label;
  final IconData? icon;
  final Color? color;

  const CircleLogoData({this.size, this.label, this.icon, this.color});
}

class CircleLogo extends StatelessWidget {
  const CircleLogo({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CircleLogoData data;

  @override
  Widget build(BuildContext context) {
    return _buildCircleLogo();
  }

  Widget _buildCircleLogo() {
    return Container(
      width: data.size != null ? data.size!.width : 40,
      height: data.size != null ? data.size!.width : 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: data.color != null
            ? data.color!.withOpacity(0.8)
            : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100),
      ),
      // padding: const EdgeInsets.all(5),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (data.label != null)
                Text(
                  data.label! + "\n" + " Tasks ",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: 0.3),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              if (data.icon != null) Icon(data.icon!)
            ],
          )),
    );
  }
}
