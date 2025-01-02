// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/service/productServices.dart';
import 'package:shop_owner/shared/drawer.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBloc() : super(LoadingProducts()) {
    late List<ProductCategoryModel> _categories;
    late List<ProductModel> _products;
    ProductCategoryModel? _lastSelectedCategory;

    bool _isProductsFetched() {
      try {
        final temp = _categories;
        return true;
      } catch (e) {
        return false;
      }
    }

    ORDER_PRODUCT_BY? _lastOrderBy;

    String _lastQuery = "";
    final ProductModelService _service = ProductModelService();
    on<ProductBlocEvent>((event, emit) {});

    // fucntion to order the products
    List<ProductModel> _order(
        List<ProductModel> products, ORDER_PRODUCT_BY order) {
      switch (order) {
        case ORDER_PRODUCT_BY.NAME:
          products.sort((a, b) => a.name.compareTo(b.name));
          break;
        case ORDER_PRODUCT_BY.NAME_DESC:
          products.sort((a, b) => a.name.compareTo(b.name));
          products = products.reversed.toList();

          break;
        case ORDER_PRODUCT_BY.PRICE:
          products.sort((a, b) => a.price.compareTo(b.price));
          products = products.reversed.toList();

          break;
        case ORDER_PRODUCT_BY.PRICE_DESC:
          products.sort((a, b) => a.price.compareTo(b.price));
          break;
        case ORDER_PRODUCT_BY.QUANTITY:
          products.sort((a, b) => a.quantity.compareTo(b.quantity));
          products = products.reversed.toList();

          break;
        case ORDER_PRODUCT_BY.QUANTITY_DESC:
          products.sort((a, b) => a.quantity.compareTo(b.quantity));
          break;
        default:
          break;
      }
      return products;
    }

    // fucntion to return those by name
    List<ProductModel> _queryByName(List<ProductModel> products) {
      if(_lastQuery.isEmpty){
        return products;
      }
      products = products.where((product) {
        return product.name.toLowerCase().contains(_lastQuery.toLowerCase());
      }).toList();
      if(_lastOrderBy == null || _lastOrderBy == ORDER_PRODUCT_BY.DEFAULT){
        products = _order(products, ORDER_PRODUCT_BY.NAME); 
        _lastOrderBy = _lastOrderBy = ORDER_PRODUCT_BY.NAME; 
      }
      return products;
    }

    Future<void> _onLoadProducts(event, emit) async {
      _lastSelectedCategory = null; 
      if (_isProductsFetched()) {
        List<ProductModel> products = _products..toList(); 

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT); 
        products = _queryByName(products);
        return emit(GotProducts(  
          categories: _categories,
          products: products,
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
        ));
      }
      //  set UI to loading state
      emit(LoadingProducts());

      //  fetch Products
      final categories = await _service.fetchProducts();

      if (categories == null) {
        return emit(FailedToLoad());
      }

      _categories = categories;

      List<ProductModel> products = [];
      for (final category in _categories) {
        products.addAll(category.items);
      }

      _products = products;

      emit(GotProducts(
        categories: _categories,
        products: _products,
        orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
        selectedCategory: _lastSelectedCategory,
      ));
    }

    Future<void> _onReloadProducts(event, emit) async {
      _lastOrderBy = null;
      _lastSelectedCategory = null;
      _lastQuery = "";

      //  set UI to loading state
      emit(LoadingProducts());

      //  fetch Products
      final categories = await _service.fetchProducts();

      if (categories == null) {
        return emit(FailedToLoad());
      }

      _categories = categories;

      List<ProductModel> products = [];
      for (final category in _categories) {
        products.addAll(category.items);
      }

      _products = products;

      emit(GotProducts(
        categories: _categories,
        products: _products,
        orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
        selectedCategory: _lastSelectedCategory,
      ));
    }

    Future<void> _onSelectCategory(event, emit) async {
      _lastSelectedCategory = event.category;
      List<ProductModel> products = _lastSelectedCategory!.items..toList();
      products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
      products = _queryByName(products);
      emit(
        GotProducts(
          categories: _categories,
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
        ),
      );
    }

    Future<void> _onSearchByName(event, emit) async {
      try {
        _lastQuery = event.query;

        // products to order
        List<ProductModel> products = _lastSelectedCategory == null
            ? _products
            : _lastSelectedCategory!.items;

        // order products based on last order if its null order them by name
        products = _order(products, ORDER_PRODUCT_BY.NAME);

        // select them based on the query
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          categories: _categories,
        ));
      } catch (e) {
        print("Error in order by event : $e");
        FailedToLoad();
      }
    }

    Future<void> _onOrderBy(event, emit) async {
      try {
        _lastOrderBy = event.order;

        // products to order
        List<ProductModel> products = _lastSelectedCategory == null
            ? _products
            : _lastSelectedCategory!.items;

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);

        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          categories: _categories,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    // event listeners
    on<LoadProducts>(_onLoadProducts);

    on<ReloadProduct>(_onReloadProducts);

    on<SelectCategory>(_onSelectCategory);

    on<OrderBy>(_onOrderBy);

    on<SearchProductByName>(_onSearchByName);
  }
}
