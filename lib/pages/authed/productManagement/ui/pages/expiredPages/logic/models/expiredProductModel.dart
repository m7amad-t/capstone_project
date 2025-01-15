import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class ExpiredProductModel extends Equatable {
  final int id;
  final ProductModel product;
  final int quantity;
  final DateTime expireDate;
  final double boughtedFor;

  const ExpiredProductModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.expireDate,
    required this.boughtedFor,
  });

  // factory from json
  factory ExpiredProductModel.fromJson(Map<String, dynamic> json) =>
      ExpiredProductModel(
        id: json['id'],
        product: ProductModel.fromJsonBasicData(json['product']),
        quantity: json['quantity'],
        boughtedFor: json['costPerItem'],
        expireDate: DateTime.parse(json['expireDate']),
      );


  // static factory list from json 
  static List<ExpiredProductModel> listFromJson(Map<String , dynamic> data){

    List<ExpiredProductModel> records = []; 

    for (var item in data['expired_products']) {
      records.add(ExpiredProductModel.fromJson(item));
    } 

    return records;

  }

  @override
  List<Object?> get props => [ id , product , quantity ,  boughtedFor  , expireDate ];
}
