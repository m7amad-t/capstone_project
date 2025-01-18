import 'dart:convert';

import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/dataExample.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';

class ExpensesServices {
  final int perPage = 10;

  Future<List<ExpensesModel>> getExpenses(int page) async {
    // memec realworld example
    await Future.delayed(const Duration(seconds: 1));

    //get data example ;;;;

    final String data = expenses_data_example;

    final json = jsonDecode(data);

    final result = ExpensesModel.listFromJson(json);

    return result;
  }
}
