
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/shared/assetPaths.dart';

class AppImageDisplayer extends StatelessWidget {
  final String imageUrl; 
  const AppImageDisplayer({super.key , required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) {
      // print('this is the palce holder callback secion..');
      return Image.asset(
        AssetPaths.placeHolder, // Your placeholder image
        fit: BoxFit.cover,
      );
    },
    errorWidget: (context, url, error) {
      // print(error);
      return Image.asset(
        AssetPaths.placeHolder, // Your error image
        fit: BoxFit.cover,
      );
    },
    fadeInDuration: const Duration(milliseconds: 500),
    fadeOutDuration: const Duration(milliseconds: 500),
    fit: BoxFit.cover,
    memCacheWidth: 2000,
    memCacheHeight: 2000,
  );
  }
}

