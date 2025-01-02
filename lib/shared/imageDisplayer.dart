import 'package:flutter/material.dart';
import 'package:shop_owner/shared/assetPaths.dart';
// instead of using this its better to use cached images , but i got an error , and i don't have enough time to fix it 
// so i have useed this way to avoid displaying (nothing till it load or when having error to laod image)


class ImageDisplayerWithPlaceHolder extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;

  const ImageDisplayerWithPlaceHolder({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(imageUrl),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Image.asset(AssetPaths.placeHolder , fit: fit),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(AssetPaths.placeHolder , fit: fit,); 
      },
     
      
      fit: fit ?? BoxFit.cover,
     
    ); 
  }

}