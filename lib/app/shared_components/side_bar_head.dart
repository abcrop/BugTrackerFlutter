import 'package:daily_task/app/constants/app_constants.dart';
import 'package:daily_task/app/shared_components/cached_image.dart';
import 'package:flutter/material.dart';

class ProjectHeadData {
  final String? imageUrl;
  final String? name;
  final String? userName;
  final double? imageSize;

  const ProjectHeadData({
    required this.imageUrl,
    this.name,
    this.userName,
    this.imageSize,
  });
}

class ProjectHead extends StatelessWidget {
  const ProjectHead({
    required this.data,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final ProjectHeadData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              const SizedBox(width: 10),
              if (data.name != null) _buildName(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Tooltip(message: data.userName!, margin: const EdgeInsets.only(top: kSpacing / 1.4) , child: CircularCachedImage(imageUrl: data.imageUrl!));
  }

  Widget _buildName() {
    return Text(
      data.name!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kFontColorPallets[0],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
