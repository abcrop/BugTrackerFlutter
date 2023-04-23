import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TextSpaceIconData {
  final String label;
  final FontWeight? labelFontWeight;
  final double? labelFontSize;
  final IconData? icon;
  final double? iconSize;
  final Color? labelColor;
  final Color? iconColor;

  const TextSpaceIconData(
      {required this.label,
      this.labelFontWeight,
      this.icon,
      this.iconSize,
      this.labelColor,
      this.iconColor,
      this.labelFontSize});
}

class TextSpaceIcon extends StatelessWidget {
  const TextSpaceIcon({
    required this.data,
    Key? key,
  }) : super(key: key);

  final TextSpaceIconData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: TextStyle(
                  fontSize: data.labelFontSize ?? 13,
                  color: data.labelColor ?? Colors.black,
                  fontWeight: data.labelFontWeight ?? FontWeight.w200,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: kSpacing / 5,
              ),
              if (data.icon != null)
                Icon(
                  data.icon,
                  color: data.iconColor != null
                      ? data.iconColor!
                      : Colors.grey.withOpacity(0.5),
                  size: data.iconSize ?? logoSizeSmall,
                )
            ],
          ),
        ));
  }
}
