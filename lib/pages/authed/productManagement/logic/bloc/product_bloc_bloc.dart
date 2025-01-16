// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/service/productServices.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/cartBloc/cart_bloc_bloc.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBloc() : super(LoadingProducts()) {
    late List<ProductCategoryModel> _categories;
    late List<ProductModel> _products;
    ProductCategoryModel? _lastSelectedCategory;
    ORDER_PRODUCT_BY? _lastOrderBy;

    String _lastQuery = "";
    final ProductModelService _service = ProductModelService();

    bool _isProductsFetched() {
      try {
        // ignore: unused_local_variable
        final temp = _categories;
        return true;
      } catch (e) {
        return false;
      }
    }

    // on<ProductBlocEvent>((event, emit) {});

    // fucntion to order the products
    List<ProductModel> _order(
      List<ProductModel> products,
      ORDER_PRODUCT_BY order,
    ) {
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
      if (_lastQuery.isEmpty) {
        return products;
      }
      products = products.where((product) {
        return product.name.toLowerCase().contains(_lastQuery.toLowerCase());
      }).toList();
      if (_lastOrderBy == null || _lastOrderBy == ORDER_PRODUCT_BY.DEFAULT) {
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
          lastQuery: _lastQuery,
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
        lastQuery: _lastQuery,
      ));
    }

    Future<void> _onReloadProducts(ReloadProduct event, emit) async {
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

      // notify cart bloc with updated product list 
      event.context.read<CartBloc>().add(
            ProductListUpdatedCheckUpdates(
              products: products,
            ),
          );
      emit(GotProducts(
        categories: _categories,
        products: _products,
        orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
        selectedCategory: _lastSelectedCategory,
        lastQuery: _lastQuery,
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
          lastQuery: _lastQuery,
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
          lastQuery: _lastQuery,
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
          lastQuery: _lastQuery,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onUpdate(UpdateProduct event, emit) async {
      try {
        List<ProductCategoryModel> categories = List.from(_categories);
        List<ProductModel> products = List.from(_products);

        final productIndex =
            products.indexWhere((p) => p.id == event.product.id);
        if (productIndex != -1) {
          products[productIndex] =
              products[productIndex].update(event.toUpdate);
        }

        for (int i = 0; i < categories.length; i++) {
          final categoryItems = List<ProductModel>.from(categories[i].items);
          final itemIndex =
              categoryItems.indexWhere((p) => p.id == event.product.id);

          if (itemIndex != -1) {
            categoryItems[itemIndex] = products[productIndex];
            categories[i] = categories[i].updateItems(categoryItems);
          }
        }

        _products = List.from(products);
        _categories = List.from(categories);

        // Apply filters if necessary
        List<ProductModel> filteredProducts = List.from(_products);

        if (_lastSelectedCategory != null) {
          // find the last selected category in updated list
          final updatedIndex = _categories.indexWhere(
              (element) => element.name == _lastSelectedCategory!.name);
          if (updatedIndex != -1) {
            filteredProducts.clear();
            filteredProducts.addAll(_categories[updatedIndex].items);
          }
        }

        // Apply ordering
        if (_lastOrderBy != null) {
          filteredProducts = _order(
              filteredProducts, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        }

        // Apply search query if exists
        if (_lastQuery.isNotEmpty) {
          filteredProducts = _queryByName(filteredProducts);
        }

        if (!event.fromCart) {
          // send event to the cart bloc to update this product if its in cart..
          event.context.read<CartBloc>().add(
                ProductUpdatedUpdateInCart(
                  updatedProduct: products[productIndex],
                ),
              );
        }

        // Emit new state with updated data
        return emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: filteredProducts,
          categories: categories,
          lastQuery: _lastQuery,
          updatedProduct: products[productIndex],
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onDelete(DeleteProduct event, emit) async {
      try {
        // delete it from main list List<ProductCategoryModel>
        for (int i = 0; i < _categories.length; i++) {
          // check if this category have the targeted product
          for (int j = 0; j < _categories[i].items.length; j++) {
            if (_categories[i].items[j].id == event.product.id) {
              _categories[i].items.removeAt(j);
            }
          }
        }

        // remove the product from main list List<ProductModel>
        _products.removeWhere((product) => product.id == event.product.id);
        List<ProductModel> products = _products;
        // applay last filter if there is any..
        if (_lastSelectedCategory != null) {
          products = _lastSelectedCategory!.items;
        }

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          categories: _categories,
          lastQuery: _lastQuery,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onInsert(InsertProduct event, emit) async {
      try {
        // delete it from main list List<ProductCategoryModel>
        for (int i = 0; i < _categories.length; i++) {
          if (_categories[i].name == event.category.name) {
            _categories[i] = _categories[i]
                .updateItems([..._categories[i].items, event.product]);
          }
        }

        // remove the product from main list List<ProductModel>
        _products.add(event.product);
        List<ProductModel> products = _products;
        // applay last filter if there is any..
        if (_lastSelectedCategory != null) {
          products = _lastSelectedCategory!.items;
        }

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          lastQuery: _lastQuery,
          categories: _categories,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onInsertCategory(InsertCategory event, emit) async {
      try {
        // add new category to main list List<ProductCategoryModel>
        _categories.add(event.category);

        // get the last product list to send it back just like last order and filters
        List<ProductModel> products = _products;
        // applay last filter if there is any..
        if (_lastSelectedCategory != null) {
          products = _lastSelectedCategory!.items;
        }

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          categories: _categories,
          lastQuery: _lastQuery,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onUpdateCategory(UpdateCategory event, emit) async {
      try {
        // find the category
        for (int i = 0; i < _categories.length; i++) {
          if (_categories[i].name == event.category.name) {
            _categories[i] = _categories[i].update(event.update);
          }
        }
        // get the last product list to send it back just like last order and filters
        List<ProductModel> products = _products;
        // applay last filter if there is any..
        if (_lastSelectedCategory != null) {
          products = _lastSelectedCategory!.items;
        }

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          categories: _categories,
          lastQuery: _lastQuery,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onDeleteCategory(DeleteCategory event, emit) async {
      try {
        // delete the category
        _categories
            .removeWhere((element) => element.name == event.category.name);

        // get the last product list to send it back just like last order and filters
        List<ProductModel> products = _products;
        // applay last filter if there is any..
        if (_lastSelectedCategory != null) {
          products = _lastSelectedCategory!.items;
        }

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          categories: _categories,
          lastQuery: _lastQuery,
        ));
      } catch (e) {
        FailedToLoad();
      }
    }

    Future<void> _onReturnProduct(ReturnProductToInventory event, emit) async {
      try {
        // find the product in the category list List<ProductcategoryModel>
        for (int i = 0; i < _categories.length; i++) {
          // get the product in the caegory products list
          int index = _categories[i]
              .items
              .indexWhere((element) => element.id == event.product.id);

          if (index >= 0) {
            final data = {
              'quantity': _categories[i].items[index].quantity + event.quantity,
            };
            // update item stok
            _categories[i].items[index] =
                _categories[i].items[index].update(data);
            // update the category
            _categories[i] = _categories[i].updateItems(_categories[i].items);
          }
        }

        // find it in product list..
        int index =
            _products.indexWhere((element) => element.id == event.product.id);
        if (index >= 0) {
          final data = {
            'quantity': _products[index].quantity + event.quantity,
          };
          // update item stok
          _products[index] = _products[index].update(data);
        }

        List<ProductModel> products = _products;
        // applay last filter if there is any..
        if (_lastSelectedCategory != null) {
          products = _lastSelectedCategory!.items;
        }

        products = _order(products, _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT);
        products = _queryByName(products);

        emit(GotProducts(
          orderby: _lastOrderBy ?? ORDER_PRODUCT_BY.DEFAULT,
          selectedCategory: _lastSelectedCategory,
          products: products,
          lastQuery: _lastQuery,
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

    on<DeleteProduct>(_onDelete);

    on<UpdateProduct>(_onUpdate);

    // on<UpdateProduct>(_onUpdate);

    on<InsertProduct>(_onInsert);

    on<InsertCategory>(_onInsertCategory);

    on<UpdateCategory>(_onUpdateCategory);

    on<DeleteCategory>(_onDeleteCategory);

    on<ReturnProductToInventory>(_onReturnProduct);
  }
}
