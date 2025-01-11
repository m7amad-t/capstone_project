import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';

class ProductReturnedModel extends Equatable {
  final int id;
  final double refund;
  final ProductModel product;
  final InvoiceModel? invoice;
  final DateTime date;
  final RETURN_PRODUCT_REASON reason;
  final String? note;
  final int returnedQuantity;

  const ProductReturnedModel({
    required this.id,
    required this.refund,
    required this.product,
    required this.date,
    required this.reason,
    required this.returnedQuantity,
    this.note,
    this.invoice,
  });

  factory ProductReturnedModel.fromJson(Map<String, dynamic> data) {
    final ProductModel product = ProductModel.fromJsonForReturnedRecords(
      data['product'],
    );

    InvoiceModel? invoice;

    if (data.containsKey('selling_record')) {
       invoice= InvoiceModel.fromJson(
        data['selling_record'],
      );
    }
   

    return ProductReturnedModel(
      id: data['id'],
      refund: data['refund'],
      product: product,
      returnedQuantity: data['quantity'],
      reason: getReasonEnumFromStrign(data['reason']),
      note: data['note'],
      invoice: invoice,
      date: DateTime.parse(data['dateTime']),
      
    );
  }

  static List<ProductReturnedModel> listFromJson(
    Map<String, dynamic> data,
  ) {
    List<ProductReturnedModel> records = [];

    for (final record in data['returns']) {
      records.add(ProductReturnedModel.fromJson(record));
    }

    return records;
  }

  @override
  List<Object?> get props => [
    id,
    refund,
    product,
    date,
    reason,
    note,
    returnedQuantity,
    invoice ?? [],
  ]; 
}
