
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';


class InvoiceRoutingExtra{

  final InvoiceModel invoice ;

  static String invoiceField = "invoice"; 

  InvoiceRoutingExtra({required this.invoice}); 

  Map<String , dynamic> get extra {
    return {
      invoiceField : invoice, 
    };
  }

}