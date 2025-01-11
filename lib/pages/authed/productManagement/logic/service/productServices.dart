// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:shop_owner/pages/authed/productManagement/logic/models/products_data_example.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';

class ProductModelService {
  Future<List<ProductCategoryModel>?> fetchProducts() async {
    try {
      // Simulate fetching products from a remote server
      await Future.delayed(const Duration(seconds: 1));

      // get fake products
      const data = productCategoryExample; 

      // decode json data
      final json = jsonDecode(data);
      
      // create model for each product category include products
      final List<ProductCategoryModel> result = ProductCategoryModel.inListFromJson(json);  
      return result;  
    } catch (e) {
      print("Error on service function : $e");
      return null;
    }
  }
}
