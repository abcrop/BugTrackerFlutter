import 'package:flutter/cupertino.dart';

import 'cached_image.dart';


class ShowImageAlert extends StatelessWidget {

  final String? image;

  ShowImageAlert({Key? key, this.image}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: InteractiveViewer(
        panEnabled: false, // Set it to false
        boundaryMargin: const EdgeInsets.all(10),
        minScale: 0.5,
        maxScale: 2,
        child: CachedImage(imageUrl: image!),
      ),
    );
  }

}