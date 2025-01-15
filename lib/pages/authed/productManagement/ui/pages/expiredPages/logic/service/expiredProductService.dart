import 'dart:convert';

import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/models/data.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/models/expiredProductModel.dart';

class ExpiredProductService {
  static int get perPages => 10;
  final int perPage = 10;

  Future<List<ExpiredProductModel>> getExpiredProducts(int page) async {
    await Future.delayed(Duration(seconds: 1));

    final res = expired_products_data;

    final json = jsonDecode(res);

    final result = ExpiredProductModel.listFromJson(json);

    return result;
  }
 

}
