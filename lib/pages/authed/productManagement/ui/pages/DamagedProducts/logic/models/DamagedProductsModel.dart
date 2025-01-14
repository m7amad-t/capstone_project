import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class DamagedProductsModel extends Equatable {
  final int id ; 
  final int quantity;
  final double boughtedPrice;
  final ProductModel product;
  final String? note;
  final DateTime dateTime;

  const DamagedProductsModel({
    required this.id,
    required this.quantity,
    required this.boughtedPrice,
    required this.product,
    required this.note,
    required this.dateTime,
  });


  



  // form json factory 
  factory DamagedProductsModel.fromJson(Map<String , dynamic> data ){
    return DamagedProductsModel(
      id: data['id'], 
      boughtedPrice: data['boughtedPrice'], 
      dateTime: DateTime.parse(data['date_time']), 
      note: data['note'],
      product: ProductModel.fromJsonBasicData(data['product']), 
      quantity: data['quantity'], 
    ); 
  }


  // return list of models 
  static  List<DamagedProductsModel> listFromJson(Map<String , dynamic> data ){
    List<DamagedProductsModel> records = []; 

    for(final record  in data['damaged_products']){

      records.add(DamagedProductsModel.fromJson(record));

    }

    return records;
  }

  @override
  List<Object?> get props => [id , product, quantity, dateTime, note ?? '', product, quantity];
}
