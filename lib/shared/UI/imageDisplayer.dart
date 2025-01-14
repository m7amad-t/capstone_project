import 'package:flutter/material.dart';
import 'package:shop_owner/shared/assetPaths.dart';
// instead of using this its better to use cached images , but i got an error , and i don't have enough time to fix it 
// so i have useed this way to avoid displaying (nothing till it load or when having error to laod image)


class ImageDisplayerWithPlaceHolder extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  const ImageDisplayerWithPlaceHolder({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.topLeft = 0.0 ,
    this.topRight = 0.0,
    this.bottomLeft = 0.0,
    this.bottomRight = 0.0 ,
  });

  @override
  Widget build(BuildContext context) {
   
    return ClipRRect(
      
      borderRadius:BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ), 
      

      child: Image(
        image: NetworkImage(imageUrl , ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Image.asset(AssetPaths.placeHolder , fit: fit);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(AssetPaths.placeHolder , fit: fit,); 
        },
       
        
        fit: fit ?? BoxFit.cover,
       
      ),
    ); 
  }

}