import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class ProductSellRecordModel extends Equatable{
  final int id;
  final int quantity;
  final int productId;
  final double price;
  final double total;
  final DateTime time;
  final ProductModel product; 


  const ProductSellRecordModel({
    required this.id,
    required this.quantity,
    required this.productId,
    required this.price,
    required this.total,
    required this.time,
    required this.product,
  });

  factory ProductSellRecordModel.fromJson(Map<String, dynamic> data) {
    return ProductSellRecordModel(
      id: data['id'],
      product: ProductModel.fromJsonBasicData(data['product']),
      quantity: data['quantity'],
      productId: data['productID'],
      price: data['price'],
      total: data['total'],
      time: DateTime.parse(data['dateTime']),
    );
  }

  static  List<ProductSellRecordModel> listFromJson(Map<String, dynamic> data) {
    
    List<ProductSellRecordModel> list = [];

    if(data['selling_records']!= null){
      data['selling_records'].forEach((item) {
        list.add(ProductSellRecordModel.fromJson(item));
      });
    }
    
    
    return list; 
  }
    
  @override
  List<Object?> get props => [id , price , productId , quantity , total , time ];


  @override
  String toString() {
    return """

-------------- selling history ---------------
  
    id : $id
    productID : $productId
    quantity : $quantity
    price : $price
    total : $total
    date : $time


-----------------------------------------------


"""; 
  }

}

