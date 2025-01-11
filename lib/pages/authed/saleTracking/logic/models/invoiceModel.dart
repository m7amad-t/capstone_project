import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/productSellModel.dart';

class InvoiceModel extends Equatable {
  final int id;
  final double total;
  final List<ProductSellModel> products;
  final DateTime time;

  const InvoiceModel({
    required this.id,
    required this.total,
    required this.products,
    required this.time,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> data) {
    List<ProductSellModel> products = []; 
    
    for(final product in data['products']){
      products.add(ProductSellModel.fromJson(product)); 
    }
    return InvoiceModel(
      total: data['total'],
      time: DateTime.parse(data['dateTime']),
      id: data['id'],
      products: products,
    );
  }

  static List<InvoiceModel> listFromJson(Map<String, dynamic> data) {
    List<InvoiceModel> invoices = [];

    

    for (final invoice in data['selling_records']) {
      invoices.add(InvoiceModel.fromJson(invoice));
    }
    return invoices;
  }

  @override
  List<Object?> get props => [total, time, id, products];
}
