import 'dart:convert';

import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/return_product_data_example.dart';

class ProductReturningService {
  static const perPage = 10;

  Future<List<ProductReturnedModel>?> getProductReturningRecords(int page) async {
    try {
      
      // simulate the real world example
      await Future.delayed(const Duration(seconds: 1));

      final jsonMap = jsonDecode(returnedProductsExample);

      final records = ProductReturnedModel.listFromJson(jsonMap);
      List<ProductReturnedModel> result = [];
      if (records.length > perPage * page) {
        for (int i = (perPage * page) + 1;
            i < records.length && (i < perPage * page + 1);
            i++) {
          result.add(records[i]);
        }
      }

      return result;
    } catch (e) {
      print('Error getting product returning records: $e');
      return null;
    }
  }

  Future<List<ProductReturnedModel>?> getProductReturningRecordsForProduct(
      int page,
      int productID      
      ) async {
    try {



      // simulate the real world example
      await Future.delayed(const Duration(seconds: 1));

      final jsonMap = jsonDecode(returnedProductsExample);
      List<ProductReturnedModel> records = ProductReturnedModel.listFromJson(jsonMap);
      
      List<ProductReturnedModel> result = [];

      for(final element in records ){

        if(element.product.id == productID){
          result.add(element); 
        }
      }
      
      
      if (result.length > perPage * page) {
        for (int i = (perPage * (page - 1));
            i < result.length && (i < perPage * page + 1);
            i++) {
          result.add(records[i]);
        }
      }

      return result;
    } catch (e) {
      print('Error getting product returning records: $e');
      return null;
    }
  }
}
