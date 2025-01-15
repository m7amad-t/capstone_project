import 'dart:convert';

import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/dataExample.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';

class ProductBoughtServcie{

  int perPage = 10 ; 

  Future<List<ProductBoughtModel>> getListFromJson(int page)async{

    await Future.delayed(const Duration(seconds: 1)); 

    final res = boughtedProductsData; 

    final json = jsonDecode(res); 

    final List<ProductBoughtModel> records = ProductBoughtModel.listFromJson(json); 

    /// apllay pagenation ///

    return records;  



  }
  Future<List<ProductBoughtModel>> getListFromJsonForProduct(int page , int id )async{

    await Future.delayed(const Duration(seconds: 1)); 

    final res = boughtedProductsData; 

    final json = jsonDecode(res); 

    final List<ProductBoughtModel> records = ProductBoughtModel.listFromJson(json); 

    records.removeWhere((product) => product.product.id!= id);

    return records;  



  }

}