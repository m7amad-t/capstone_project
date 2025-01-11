// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productReturnedModel.dart';
// import 'package:shop_owner/pages/authed/productManagement/logic/models/productReturnsModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/service/productReturningService.dart';

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
        _lastEnd = event.end;
        _lastStart = event.start;

        if (_lastProduct != null) {
          if (_lastProduct!.id != event.product.id) {
            _clear();
            _lastProduct = event.product;
            _lastEnd = event.end;
            _lastStart = event.start;
          }
        } else {
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
        emit(FailedToLoadProductReturnedRecords());
        return;
      }
    }

    // event Listeners
    on<LoadReturnedProduct>(_onLoad);

    on<ReloadReturnedProduct>(_onReload);

    on<LoadReturnedProductInRange>(_onLoadInRange);

    on<FilterByReason>(_onFilter);
  }
}
