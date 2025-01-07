import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class ProductCategoryModel extends Equatable {
  final String name;
  final List<ProductModel> items;

  const ProductCategoryModel({required this.name, required this.items});

  // from json
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    
    List<ProductModel> items = [];
    for(final item in json['items']) {
      items.add(ProductModel.fromJson(item));
    }
    return ProductCategoryModel(
      name: json['name'],
      items: items,
    );
  }
  // from json
  static List<ProductCategoryModel> inListFromJson(Map<String, dynamic> json) {
    List<ProductCategoryModel> list = [];

    for(final category in json['categories']) {
      list.add(ProductCategoryModel.fromJson(category));
    }

    return list;
  
  }


  

  


  // update items 
  ProductCategoryModel updateItems(List<ProductModel> products){
    return ProductCategoryModel(
      name: name,
      items: products , 
    );
  }

  // udpate 
  ProductCategoryModel update(Map<String , dynamic> map){
    return ProductCategoryModel(
      name: map['name']?? name,
      items: items , 
    );
  }

  @override
  String toString() {
    return """

----------- Product Category --------------
 Name: $name
 Item length: ${items.length}
----------------------------------------

""";
  }

  @override
  List<Object?> get props => [name, items.length , ...items];
}
