import 'dart:convert';

import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/selling_records_example_data.dart';

class SellingService {
  final int perPage = 10;

  Future<List<InvoiceModel>> getProductsSellingRecords(int page) async {
    // semulate realworld example
    await Future.delayed(const Duration(seconds: 1));

    final json = jsonDecode(selling_record_example);

    // create a model for them

    List<InvoiceModel> records = [];  

    // todo : applay pagination
    records = InvoiceModel.listFromJson(json);

    if(page == 1){
      records = records.sublist(0 ,9); 
    }else {
      records = records.sublist(10 ,17); 
    }


    return records;
  }
}
