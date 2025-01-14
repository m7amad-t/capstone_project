// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/service/productBoughtService.dart';

part 'buying_products_bloc_event.dart';
part 'buying_products_bloc_state.dart';

class BuyingProductsBloc
    extends Bloc<BuyingProductsBlocEvent, BuyingProductsBlocState> {
  BuyingProductsBloc() : super(LoadingBoughtForProducts()) {
    final ProductBoughtServcie _service = ProductBoughtServcie();

    List<ProductBoughtModel> _records = [];
    DateTimeRange? _lastRange;
    int _currentPage = 1;
    bool _isEnded = false;

    void _clear() {
      _lastRange = null;
      _isEnded = false;
      _records.clear();
      _currentPage = 1;
    }

    Future<void> _loadMore() async {
      final res = await _service.getListFromJson(_currentPage++);
      if (res.length < _service.perPage) {
        _isEnded = true;
      }
      _records.addAll(res);
    }

    Future<void> _onLoad(LoadBoughtHistory event, emit) async {
      // if all records have been loaded
      if (_isEnded) {
        emit(
          GotProductsBoughtHistory(
            records: _records,
            range: _lastRange,
            ended: _isEnded,
          ),
        );
      }

      // load records
      await _loadMore();

      emit(
        GotProductsBoughtHistory(
          records: _records,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    Future<void> _onReload(ReloadBoughtHistory event, emit) async {
      _clear();

      emit(LoadingBoughtForProducts());

      // load records
      await _loadMore();

      emit(
        GotProductsBoughtHistory(
          records: _records,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    Future<void> _onLoadInRange(
      LoadBoughtHistoryInRange event,
      emit,
    ) async {
      if (_lastRange == null) {
        _clear();
        emit(LoadingBoughtForProducts());
      }

      if (_isEnded) {
        return emit(GotProductsBoughtHistory(
          records: _records,
          range: _lastRange,
          ended: _isEnded,
        ));
      }

      // load records
      await _loadMore();

      emit(
        GotProductsBoughtHistory(
          records: _records,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    Future<void> _onBoughtProduct(
      BoughtProduct event,
      emit,
    ) async {
      _records.add(event.record);

      emit(
        GotProductsBoughtHistory(
          records: _records,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    // event listeners..

    on<LoadBoughtHistory>(_onLoad);

    on<ReloadBoughtHistory>(_onReload);

    on<LoadBoughtHistoryInRange>(_onLoadInRange);

    on<BoughtProduct>(_onBoughtProduct);
  }
}
