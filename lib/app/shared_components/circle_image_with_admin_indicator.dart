import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/helpers/app_helpers.dart';
import 'cached_image.dart';

class CircleAvatarWithAdminIndicator extends StatelessWidget {
  const CircleAvatarWithAdminIndicator({
    Key? key,
    required this.isAdmin,
    required this.imageUrl,
    this.imageTooltipMsg,
    this.size,
  }) : super(key: key);

  final bool? isAdmin;
  final String? imageUrl;
  final String? imageTooltipMsg;
  final HeightWidth? size;

  @override
  Widget build(BuildContext context) {
    var tooltipMessage = "";
    if(imageTooltipMsg != null) {
      tooltipMessage = imageTooltipMsg!;
    }
    return SizedBox(
      width: size != null ? size!.width : 40,
      height: size != null ? size!.height : 40,
      child: Stack(
        children: [
          Tooltip(
            message: tooltipMessage,
            child: CircularCachedImage(imageUrl: imageUrl,)
          ),
          if (isAdmin!)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              alignment: Alignment.bottomRight,
              child: Tooltip(
                message: "Admin",
                child: Icon(
                  Icons.admin_panel_settings_rounded,
                  color: Theme.of(context).primaryColor,
                  shadows: const [
                    BoxShadow(
                        color: Colors.white, spreadRadius: 1, blurRadius: 3)
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
