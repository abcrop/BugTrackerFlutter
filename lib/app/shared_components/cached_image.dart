import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CircularCachedImage extends StatelessWidget {
  const CircularCachedImage({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    var fallBackImage =
        "https://thumbs.dreamstime.com/b/yasaka-pagoda-sannen-zaka-street-kyoto-japan-yasaka-pagoda-sannen-zaka-street-kyoto-japan-118600109.jpg";
    return CachedNetworkImage(
      fit: BoxFit.fill,
        imageUrl: imageUrl ??
            fallBackImage,
        imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 25,
              backgroundImage: imageProvider,
            ),
        placeholder: (context, url) => const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(ImageRasterPath.man),
            ),
        errorWidget: (context, url, error) => const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(ImageRasterPath.man),
            ),
        fadeOutDuration: const Duration(seconds: 1),
        fadeInDuration: const Duration(seconds: 3));
  }
}

class CachedImage extends StatelessWidget {
  const CachedImage({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    var fallBackImage =
        "https://thumbs.dreamstime.com/b/yasaka-pagoda-sannen-zaka-street-kyoto-japan-yasaka-pagoda-sannen-zaka-street-kyoto-japan-118600109.jpg";
    return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl ??
            fallBackImage,
        imageBuilder: (context, imageProvider) => Image(image: imageProvider),
        placeholder: (context, url) => CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white)),
        errorWidget: (context, url, error) => const Image(
          image: AssetImage(ImageRasterPath.man),
        ),
        fadeOutDuration: const Duration(seconds: 1),
        fadeInDuration: const Duration(seconds: 3));
  }
}
