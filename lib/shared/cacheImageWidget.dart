import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/shared/assetPaths.dart';


// it have error , its diplay the place holder no matter if there is any error or not while loading the image..
class CachedImageDisplayer extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const CachedImageDisplayer({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.memCacheWidth = 2000,
    this.memCacheHeight = 2000,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset(
        AssetPaths.placeHolder,
        fit: fit,
      ),
      errorWidget: (context, url, error) =>
         Image.asset(
          AssetPaths.placeHolder,
          fit: fit,
        ),
      
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      fit: fit ?? BoxFit.cover,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
     
      
    );
  }


}