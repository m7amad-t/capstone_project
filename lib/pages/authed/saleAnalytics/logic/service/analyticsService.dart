import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/categoriesRelated/categoryRevenueModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/categoriesRelated/categoriesDamagedModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/categoriesRelated/categoriesReturnedModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/productTrendModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/categoriesRelated/categorySaleModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/damagedAnalyticsModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/expensesAnalyticsModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/productRevenueModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/productSaleModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/returnedProductsAnalyticsModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/revenueModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/totalSaleModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/categoriesTotalDamagedDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/categoriesTotalReturnedDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/categoriesTotalRevenueDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/categoriesTotalSaleDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/productTrendDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/expensesDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/laptopDamagedDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/laptopReturnedDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/laptopRevenuDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/laptopSaleDataExample.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/revenueDataExamole.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/data/totalSaleDataExample.dart';

class AnalyticsService {
  Future<TotalSaleModel> getTotalSale(DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    final res = totalSaleDataExample;
    final json = jsonDecode(res);
    final TotalSaleModel result = TotalSaleModel.fromJson(json);

    return result;
  }

  Future<TotalRevenueModel> getTotalRevenue(DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    final res = revenueDataExample;
    final json = jsonDecode(res);
    final TotalRevenueModel result = TotalRevenueModel.fromJson(json);

    return result;
  }

  Future<ProductRevenueModel> getProductRevenue(
      DateTimeRange range, int productID) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    if (productID != 2) {
      return ProductRevenueModel(
        name: "",
        months: [],
        totalRevenue: 0,
        range: range,
        id: -1,
      );
    }

    final res = laptopRevenueDataExaple;
    final json = jsonDecode(res);
    final ProductRevenueModel result = ProductRevenueModel.fromJson(json);

    return result;
  }

  Future<ProductSaleModel> getProductSale(
      DateTimeRange range, int productID) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    if (productID != 2) {
      return ProductSaleModel(
        name: "",
        months: [],
        totalSale: 0,
        range: range,
        id: -1,
      );
    }

    final res = laptopSaleDataExample;
    final json = jsonDecode(res);
    final ProductSaleModel result = ProductSaleModel.fromJson(json);

    return result;
  }

  Future<ReturnedProductAnalyticsModel> getProductReturnedData(
      DateTimeRange range, int productID) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    if (productID != 2) {
      return ReturnedProductAnalyticsModel(
        productName: "",
        range: range,
        id: -1,
        months: const [],
        totalProducts: 0,
      );
    }

    const res = laptopReturnedDataExample;
    final json = jsonDecode(res);
    final ReturnedProductAnalyticsModel result =
        ReturnedProductAnalyticsModel.fromJson(json);

    return result;
  }

  Future<DamagedProductAnalyticsModel> getProductDamagedData(
      DateTimeRange range, int productID) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    if (productID != 2) {
      return DamagedProductAnalyticsModel(
        productName: "",
        range: range,
        id: -1,
        months: const [],
        totalDamaged: 0,
        totalLost: 0,
      );
    }

    const res = laptopDamagedDataExample;
    final json = jsonDecode(res);
    final DamagedProductAnalyticsModel result =
        DamagedProductAnalyticsModel.fromJson(json);

    return result;
  }

  Future<CategoriesRevenueModel> getCategoryRevenueData(
      DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    const res = categoriesTotalRevenueDataExample;
    final json = jsonDecode(res);
    final CategoriesRevenueModel result = CategoriesRevenueModel.fromJson(json);

    return result;
  }

  Future<CategoriesSaleModel> getCategoriesSaleData(DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    const res = categoriesTotalSaleDataExample;
    final json = jsonDecode(res);
    final CategoriesSaleModel result = CategoriesSaleModel.fromJson(json);

    return result;
  }

  Future<CategoriesReturnedModel> getCategoriesReturnedData(
      DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    const res = categoriesReturnedDataExample;
    final json = jsonDecode(res);
    final CategoriesReturnedModel result =
        CategoriesReturnedModel.fromJson(json);

    return result;
  }

  Future<CategoriesDamagedModel> getCategoriesDamagedData(
      DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    const res = categoriesDamagedDataExample;
    final json = jsonDecode(res);
    final CategoriesDamagedModel result = CategoriesDamagedModel.fromJson(json);

    return result;
  }

  Future<ExpensesAnalyticsModel> getAanalyticsData(DateTimeRange range) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    const res = expensesDataExample;
    final json = jsonDecode(res);
    final ExpensesAnalyticsModel result = ExpensesAnalyticsModel.fromJson(json);

    return result;
  }

  Future<ProductsTrendModel> getTrendCategories(
    DateTimeRange range,
  ) async {
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    const res = categoriesTrendDataExample;
    final json = jsonDecode(res);
    final ProductsTrendModel result = ProductsTrendModel.fromJson(json);

    return result;
  }
}
