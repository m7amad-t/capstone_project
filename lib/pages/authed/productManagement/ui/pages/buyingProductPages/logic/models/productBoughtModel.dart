import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class ProductBoughtModel extends Equatable {
  final ProductModel product;
  final int quantity;
  final double pricePerItem;
  final DateTime dateTime;
  final DateTime? expireDate;
  final String? note;

  const ProductBoughtModel({
    required this.product,
    required this.quantity,
    required this.pricePerItem,
    required this.dateTime,
    this.expireDate,
    this.note,
  });


  // factory from json to model 
  factory ProductBoughtModel.fromJson(Map<String , dynamic> data){
    return ProductBoughtModel(
      product: ProductModel.fromJsonBasicData(data['product']),
      quantity: data['quantity'],
      pricePerItem: data['price_per_item'],
      dateTime: DateTime.parse(data['date_time']),  
      expireDate: data['expire_date']!= null? DateTime.parse(data['expire_date']) : null,
      note: data['note'],
    );
  }


  static List<ProductBoughtModel> listFromJson (Map<String , dynamic> data){

    List<ProductBoughtModel> records = []; 

    for(final record in data['boughted']){
      records.add(ProductBoughtModel.fromJson(record));
    }

    return records; 

  }

  @override
  List<Object?> get props => [product, quantity, pricePerItem, dateTime, note ?? "", expireDate ??[]]; 
}
