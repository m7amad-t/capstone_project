import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesRecords.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/recordDataExample.dart';

class ExpesnesRecordsService {
  int perPage = 10;

  Future<List<ExpensesRecordsModel>> getRecords(
      {required int page, required ExpensesModel expenses}) async {
    // semulate
    await Future.delayed(const Duration(seconds: 1));

    final res = record_data_example;

    final json = jsonDecode(res);

    for (final exp in json['expenses']) {
      if (exp['name'] == expenses.name) {
        return ExpensesRecordsModel.listFromJson(exp);
      }
    }

    return [];
  }

  Future<List<ExpensesRecordsModel>> getRecordsInRange(
      {required int page,
      required ExpensesModel expenses,
      required DateTimeRange range}) async {
    // semulate
    await Future.delayed(const Duration(seconds: 1));

    final res = record_data_example;

    final json = jsonDecode(res);

    for (final exp in json['expenses']) {
      if (exp['name'] == expenses.name) {
        return ExpensesRecordsModel.listFromJson(exp);
      }
    }

    return [];
  }

  Future<bool> AddNewRecord({
    required ExpensesModel expenses,
    required ExpensesRecordsModel record,
  }) async {
    // semulate
    await Future.delayed(const Duration(seconds: 1));

    final r = Random(); 

    int res = r.nextInt(2); 

    return res != 1 ? true : false; 
    
  }
  
  Future<bool> DeleteRecord({
    required ExpensesModel expenses,
    required ExpensesRecordsModel record,
  }) async {
    // semulate
    await Future.delayed(const Duration(seconds: 1));

    final r = Random(); 

    int res = r.nextInt(2); 

    return res !=1 ? true : false; 
    
  }
}
