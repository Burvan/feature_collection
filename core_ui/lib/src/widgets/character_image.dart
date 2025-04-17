import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  final String imagePath;

  const CharacterImage({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return CachedNetworkImage(
      imageUrl: imagePath,
      fit: BoxFit.cover,
      height: mediaQueryData.size.height * AppScale.scaleZero2,
      width: mediaQueryData.size.width * AppScale.scaleZero3,
    );
  }
}
