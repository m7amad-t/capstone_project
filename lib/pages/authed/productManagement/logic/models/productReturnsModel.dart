import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/sellingRecordModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/returnedProductBlocs/shared/enum.dart';

class ProductReturnModel extends Equatable {
  final int id;
  final ProductSellRecordModel? sellingRecord;
  final ProductModel product;
  final double returned;
  final int quantity;
  final DateTime time;
  final RETURN_PRODUCT_REASON reson;
  final String description;

  const ProductReturnModel({
    required this.id,
    this.sellingRecord,
    required this.product,
    required this.returned,
    required this.quantity,
    required this.time,
    required this.reson,
    required this.description,
  });

  factory ProductReturnModel.fromJson(Map<String, dynamic> data) {
    final ProductModel product =
        ProductModel.fromJsonForReturnedRecords(data['product']);

    ProductSellRecordModel? sellingRecord ;

    if (data.containsKey('selling_record')) {
      sellingRecord = ProductSellRecordModel.fromJson(
        data['selling_record'],
      );
    }

    return ProductReturnModel(
      description: data['note'],
      returned: data['returned'],
      reson: getReasonEnumFromStrign(data['reason']),
      quantity: data['quantity'],
      id: data['id'],
      product: product,
      sellingRecord: sellingRecord,
      time: DateTime.parse(data['dateTime']),
    );
  }

  static List<ProductReturnModel> listFromJson(
    Map<String, dynamic> data,
  ) {
    List<ProductReturnModel> records = [];

    for (final record in data['returns']) {
      records.add(ProductReturnModel.fromJson(record));
    }

    return records;
  }

  @override
  List<Object?> get props => [
        product,
        sellingRecord??[],
        reson,
        quantity,
        id,
        time,
        returned,
      ];
}
