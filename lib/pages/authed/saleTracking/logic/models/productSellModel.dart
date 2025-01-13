import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class ProductSellModel extends Equatable {
  final int quantity;
  final ProductModel product;

  const ProductSellModel({
    required this.quantity,
    required this.product,
  });

  factory ProductSellModel.fromJson(Map<String, dynamic> data) {
    return ProductSellModel(
      quantity: data['quantity'],
      product: ProductModel.fromJsonBasicData(data['product']),
    );
  }

  static List<ProductSellModel> listFromJson(Map<String, dynamic> data) {
    List<ProductSellModel> products = [];

    for (final record in data['products']) {
      products.add(ProductSellModel.fromJson(record));
    }

    return products;
  }

  @override
  List<Object?> get props => [quantity, product];
}
