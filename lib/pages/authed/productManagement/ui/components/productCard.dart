import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/productEditorPage.dart';
import 'package:shop_owner/shared/imageDisplayer.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final List<ProductCategoryModel> categories;
  const ProductCard({

    super.key,
    required this.categories, 
    required this.product,
  });

  String get _trimName {
    int maxLength = 20;
    if (product.name.length > maxLength) {
      return '${product.name.substring(0, maxLength)}...';
    }
    return product.name;
  }

  String get _trimDescription {
    int maxLength = 100;
    if (product.description.length > maxLength) {
      return '${product.description.substring(0, maxLength)}...';
    }
    return product.description;
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    final isLTR = context.fromLTR;
    
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductEditorPage(product: product , categories: categories,),
          ),
        ); 
      },
      child: isLTR ? cardLTR(context, isLTR, _textStyle) : cardRTL(context, isLTR, _textStyle),
    ); 
    
  }

  Widget cardLTR(context, isLTR, _textStyle) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s100,
        maxWidth: AppSizes.s300,
      ),
      child: Card(
        child: Stack(
          children: [
            //  back  (image)
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Text('SLAAAAA'),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),

            //  middle (gradeant)
            Row(
              mainAxisAlignment:
                  isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor.withOpacity(0.1),
                        ],
                      ),
                      // image: DecorationImage(
                      //   image: NetworkImage(widget.product.imageUrl),
                      //   fit: BoxFit.cover,
                      // ),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(AppSizes.s16),
                      //   bottomLeft: Radius.circular(AppSizes.s16),
                      // ),
                      // color: Theme.of(context).cardColor,
                    ),
                    // child: Text('SLAAAAA'),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),

            // front texts
            Row(
              mainAxisAlignment:
                  isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              _trimName,
                              style: _textStyle.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Opacity(
                              opacity: 0.4,
                              child: Text(
                                "\$${product.price}",
                                style: _textStyle.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          _trimDescription,
                          style: _textStyle.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(product.quantity.toString(),
                        style: _textStyle.bodyLarge),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRTL(context, isLTR, _textStyle) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s100,
        maxWidth: AppSizes.s300,
      ),
      child: Card(
        child: Stack(
          children: [
            //  back  (image)
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
                  child: Container(),
                ),
                
                Expanded(
                  flex: 2,
                  child: Container(
                    height:AppSizes.s100 ,
                    width: 200,
                        child :ImageDisplayerWithPlaceHolder(imageUrl: product.imageUrl),
                    // child: Text('SLAAAAA'),
                  ),
                ),
              ],
            ),

            //  middle (gradeant)
            Row(
              mainAxisAlignment:
                  isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor.withOpacity(0.1),
                        ],
                      ),
                    ),
                    // child: Text('SLAAAAA'),
                  ),
                ),
              ],
            ),

            // front texts
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      product.quantity.toString(),
                      style: _textStyle.bodyLarge,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          
                          Expanded(
                            flex: 1,
                            child: Opacity(
                              opacity: 0.4,
                              child: Text(
                                "\$${product.price}",
                                textDirection: TextDirection.ltr,
                                style: _textStyle.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _trimName,
                              textDirection: TextDirection.ltr,
                              style: _textStyle.bodyMedium!.copyWith(
                            
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          _trimDescription,
                          textDirection: TextDirection.ltr,
                          style: _textStyle.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
