import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class ProductCategoryModel extends Equatable {
  final String name;
  final List<ProductModel> items;

  const ProductCategoryModel({required this.name, required this.items});

  // from json
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    
    List<ProductModel> _items = [];
    for(final item in json['items']) {
      _items.add(ProductModel.fromJson(item));
    }
    return ProductCategoryModel(
      name: json['name'],
      items: _items,
    );
  }
  // from json
  static List<ProductCategoryModel> inListFromJson(Map<String, dynamic> json) {
    List<ProductCategoryModel> _list = [];

    for(final category in json['categories']) {
      _list.add(ProductCategoryModel.fromJson(category));
    }

    return _list;
  
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
  List<Object?> get props => [name, items.length];
}
