// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/service/productReturningService.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/appDialogs.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/uiHelper.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

part 'returned_product_bloc_event.dart';
part 'returned_product_bloc_state.dart';

class ReturnedProductBloc
    extends Bloc<ReturnedProductBlocEvent, ReturnedProductBlocState> {
  ReturnedProductBloc() : super(LoadingReturedProduct()) {
    List<ProductReturnedModel> _records = [];
    RETURN_PRODUCT_REASON? _lastFilter;
    bool _isEnd = false;
    int _currentPage = 1;
    const int _perPage = ProductReturningService.perPage;
    DateTime? _lastStart;
    DateTime? _lastEnd;
    ProductModel? _lastProduct;
    final ProductReturningService _service = ProductReturningService();

    void _clear() {
      _currentPage = 1;
      _isEnd = false;
      _lastEnd = null;
      _lastStart = null;
      _lastProduct = null;
      _lastFilter = null;
      _records = [];
    }

    List<ProductReturnedModel> _filter() {
      if (_lastFilter == null) {
        return _records;
      }
      List<ProductReturnedModel> result = [];
      for (final element in _records) {
        if (element.reason == _lastFilter) {
          result.add(element);
        }
      }
      return result;
    }

    Future<void> _loadMore() async {
      final newRecords = await _service.getProductReturningRecordsForProduct(
        _currentPage++,
        _lastProduct!.id,
      );

      if (newRecords == null) {
        throw Exception('Error on laoding (more) records');
      }

      if (newRecords.length < _perPage) {
        _isEnd = true;
      }

      _records.addAll(newRecords);
    }

    Future<void> _onFilter(FilterByReason event, emit) async {
      try {
        _lastFilter = event.reason;

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // apply last filters
        result = _filter();

        // sendBack records
        emit(
          GotReturnedForProduct(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductReturnedRecords());
        return;
      }
    }

    Future<void> _onLoad(LoadReturnedProduct event, emit) async {
      try {
        if (_lastProduct != null) {
          if (_lastProduct!.id != event.product.id) {
            emit(LoadingReturedProduct());
            _clear();
            _lastProduct = event.product;
          }
        } else {
          emit(LoadingReturedProduct());
          _lastProduct = event.product;
        }

        if (_isEnd) {
          return;
        }

        // load more records
        await _loadMore();

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // applay last filters
        result = _filter();

        // sendBack records
        emit(
          GotReturnedForProduct(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        print(e);
        emit(FailedToLoadProductReturnedRecords());
        return;
      }
    }

    Future<void> _onReload(ReloadReturnedProduct event, emit) async {
      try {
        _clear();
        emit(LoadingReturedProduct());

        _lastProduct = event.product;

        // load more records
        await _loadMore();

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // sendBack records
        emit(
          GotReturnedForProduct(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductReturnedRecords());
        return;
      }
    }

    Future<void> _onLoadInRange(LoadReturnedProductInRange event, emit) async {
      try {
        if (_lastStart == null || _lastEnd == null) {
          emit(LoadingReturedProduct());
          _clear();
          _lastEnd = event.end;
          _lastStart = event.start;
          _lastProduct = event.product;
        }

        if (_lastProduct != null) {
          if (_lastProduct!.id != event.product.id) {
            _clear();
            _lastProduct = event.product;
            _lastEnd = event.end;
            _lastStart = event.start;
            emit(LoadingReturedProduct());
          }
          if (_lastEnd == event.end || _lastStart == event.start) {
            _clear();
            _lastProduct = event.product;
            _lastEnd = event.end;
            _lastStart = event.start;
            emit(LoadingReturedProduct());
          }
        } else {
          _lastProduct = event.product;
          _lastEnd = event.end;
          _lastStart = event.start;
        }

        if (_isEnd) {
          return;
        }

        // load more records
        await _loadMore();

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // applay last filters
        result = _filter();

        // sendBack records
        emit(
          GotReturnedForProduct(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductReturnedRecords());
        return;
      }
    }

    Future<void> _onReturnProduct(ReturnProduct event, emit) async {
      try {
        locator<AppDialogs>().showCostumTextLoading('Returning Product');

        await Future.delayed(const Duration(seconds: 1));

        _records.add(event.product);

        // notify other related bloc..

        // update the items stok
        if (event.product.backToInventory) {
          event.context.read<ProductBloc>().add(
                ReturnProductToInventory(
                  product: event.product.product,
                  quantity: event.product.returnedQuantity,
                ),
              );
          showSnackBar(
            message: SuccessSnackBar(
              title: 'Product Returned to Inventory',
              message: "Product Returned to Inventory",
            ),
          );
        } else {
          // send the item to the dmaged good inventory...
          showSnackBar(
            message: SuccessSnackBar(
              title: 'Product Returned to Damged Goods Inventory',
              message: "Product Returned to Damged Goods Inventory",
            ),
          );
        }

        // todo : notify Products reteturned bloc.. mean ,bloc of all returned products

        locator<AppDialogs>().disposeAnyActiveDialogs();
        // // sendBack records
        // emit(
        //   GotReturnedForProduct(
        //     records: List.from(_records),
        //     filter: _lastFilter,
        //     start: _lastStart,
        //     end: _lastEnd,
        //     isLast: _isEnd,
        //   ),
        // );
        GoRouter.of(event.context).go(AppRoutes.home);
      } catch (e) {
        emit(FailedToLoadProductReturnedRecords());
        return;
      }
    }

    // event Listeners
    on<LoadReturnedProduct>(_onLoad);

    on<ReloadReturnedProduct>(_onReload);

    on<LoadReturnedProductInRange>(_onLoadInRange);

    on<FilterByReason>(_onFilter);

    on<ReturnProduct>(_onReturnProduct);
  }
}
