import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets_paths.dart';

class TileImage extends StatelessWidget {
  const TileImage({
    super.key,
    required this.isGroup,
    required this.image,
  });

  final bool isGroup;
  final String image;

  @override
  Widget build(BuildContext context) {
    String defaultImage = isGroup ? AssetsPaths.group : AssetsPaths.contact;

    return Container(
      height: 60,
      width: 60,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Center(
        child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: image == ''
                    ? DecorationImage(
                        image: AssetImage(defaultImage), fit: BoxFit.fill)
                    : DecorationImage(
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.fill))),
      ),
    );
  }
}
