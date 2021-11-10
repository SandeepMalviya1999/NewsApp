import 'package:flutter/material.dart';
import 'package:newsapp/constant/image.dart';

import 'no_image.dart';

class ImageViewWidget extends StatelessWidget {
  final String title;
  final String imageURL;

  const ImageViewWidget({Key? key, required this.title, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: title,
        child: FadeInImage(
            placeholder: const AssetImage(ImageRes.logo),
            fit: BoxFit.cover,
            image: NetworkImage(imageURL),
            imageErrorBuilder: (context, error, stackTrace) => const NoImageWidget(isBig: false)));
  }
}
