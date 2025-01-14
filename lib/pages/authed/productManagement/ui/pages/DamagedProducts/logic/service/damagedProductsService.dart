import 'dart:convert';

import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/DamagedProductsModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/data_example.dart';

class DamagedProductsService{

  static int get perPages  => 10 ; 
  final int perPage = 10 ; 


  Future<List<DamagedProductsModel>> getDamagedProducts(int page)async{

    await Future.delayed(Duration(seconds: 1)); 

    // GET DATA 
    final res = damaged_products_data_example; 

    final json = jsonDecode(res); 


    final List<DamagedProductsModel> result = DamagedProductsModel.listFromJson(json); 

    return result;

  

  }
  Future<List<DamagedProductsModel>> getDamagedProduct(ProductModel product ,int page)async{

    await Future.delayed(Duration(seconds: 1)); 

    // GET DATA 
    final res = damaged_products_data_example; 

    final json = jsonDecode(res); 


    final List<DamagedProductsModel> result = DamagedProductsModel.listFromJson(json); 

    result.removeWhere((elemenet)=>elemenet.product.id != product.id); 

    return result;



  }

}