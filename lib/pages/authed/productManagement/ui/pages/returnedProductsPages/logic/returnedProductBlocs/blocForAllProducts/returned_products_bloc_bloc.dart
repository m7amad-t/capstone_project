// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/service/productReturningService.dart';

part 'returned_products_bloc_event.dart';
part 'returned_products_bloc_state.dart';

class ReturnedProductsBloc
    extends Bloc<ReturnedProductsBlocEvent, ReturnedProductsBlocState> {
  ReturnedProductsBloc() : super(LoadingReturedProducts()) {
    List<ProductReturnedModel> _records = [];
    RETURN_PRODUCT_REASON? _lastFilter;
    bool _isEnd = false;
    int _currentPage = 1;
    const int _perPage = ProductReturningService.perPage;
    DateTime? _lastStart;
    DateTime? _lastEnd;
    final ProductReturningService _service = ProductReturningService();

    void _clear() {
      _currentPage = 1;
      _isEnd = false;
      _lastEnd = null;
      _lastStart = null;
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
      final newRecords = await _service.getProductReturningRecords(
        _currentPage++,
      );

      if (newRecords == null) {
        throw Exception('Error on laoding (more) records');
      }
      if (newRecords.length < _perPage) {
        _isEnd = true;
      }

      _records.addAll(newRecords);
    }

    Future<void> _onLoad(LoadReturnedRecordsForAll event, emit) async {
      try {
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
          GotReturnedForProducts(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductsReturnedRecords());
        return;
      }
    }

    Future<void> _onReload(ReloadReturnedRecordsForAll event, emit) async {
      try {
        // clear everything
        _records = [];
        _isEnd = false;
        _currentPage = 1;
        _lastFilter = null;
        _lastStart = null;
        _lastEnd = null;

        // load more records
        await _loadMore();

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // sendBack records
        emit(
          GotReturnedForProducts(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductsReturnedRecords());
        return;
      }
    }

    Future<void> _onLoadInRange(
        LoadReturnedRecordsForAllInRange event, emit) async {
      try {
        if (_lastEnd == null || _lastStart == null) {
          _clear();
        }
        // sign new values
        _lastStart = event.start;
        _lastEnd = event.end;

        // load more records
        await _loadMore();

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // applay last filters
        result = _filter();

        // sendBack records
        emit(
          GotReturnedForProducts(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductsReturnedRecords());
        return;
      }
    }

    Future<void> _onFilterProductsByReason(FilterByReason event, emit) async {
      try {
        _lastFilter = event.reason;

        // create a deep coppy of the current records
        List<ProductReturnedModel> result = List.from(_records);

        // apply last filter
        _filter();

        // sendBack records
        emit(
          GotReturnedForProducts(
            records: result,
            filter: _lastFilter,
            start: _lastStart,
            end: _lastEnd,
            isLast: _isEnd,
          ),
        );
      } catch (e) {
        emit(FailedToLoadProductsReturnedRecords());
        return;
      }
    }

    // event listeners
    on<LoadReturnedRecordsForAll>(_onLoad);

    on<ReloadReturnedRecordsForAll>(_onReload);

    on<LoadReturnedRecordsForAllInRange>(_onLoadInRange);

    on<FilterByReason>(_onFilterProductsByReason);
  }
}
