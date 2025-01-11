
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

abstract class ProductManagementSubRoutesBase{
  final String categoriesField = "categories";
  final String categoryField = "category";
  final String  productField = "product";

  final List<ProductCategoryModel> categories ;

  ProductManagementSubRoutesBase({required this.categories}); 

  Map<String , dynamic> get getExtra ;  

}

class ReturnProductExtra {

  final ProductModel product ;

  ReturnProductExtra({required this.product});

  
  Map<String, dynamic> get getExtra {
      return {
        'product' : product, 
      }; 
    
  }
}


class AddNewProductExtra extends ProductManagementSubRoutesBase{
  
  AddNewProductExtra({required super.categories});
  
  @override
  Map<String, dynamic> get getExtra {
      return {
        super.categoriesField : super.categories, 
        super.productField : null, 
      }; 
    
  }

}

class UpdateProductExtra extends ProductManagementSubRoutesBase{
  final ProductModel product ; 
  UpdateProductExtra({required super.categories , required this.product});
  
  @override
  Map<String, dynamic> get getExtra {
      return {
        super.categoriesField : super.categories, 
        super.productField : product, 
      }; 
    
  }
}



class AddNewCategoryExtra extends ProductManagementSubRoutesBase{
  
  AddNewCategoryExtra({required super.categories});
  
  @override
  Map<String, dynamic> get getExtra {
      return {
        super.categoriesField : super.categories, 
        super.productField : null, 
      }; 
    
  }

}

class UpdateCategoryExtra extends ProductManagementSubRoutesBase{
  final ProductCategoryModel category ; 
  UpdateCategoryExtra({required super.categories , required this.category});
  
  @override
  Map<String, dynamic> get getExtra {
      return {
        super.categoriesField : super.categories, 
        super.categoryField : category, 
      }; 
    
  }

}
