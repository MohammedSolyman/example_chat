import 'package:flutter/material.dart';

import '../constants/assets_paths.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsPaths.chatIcon,
      height: 150,
      width: 150,
    );
  }
}
