// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/service/selling_service.dart';

part 'selling_bloc_event.dart';
part 'selling_bloc_state.dart';

class SellingBloc extends Bloc<SellingBlocEvent, SellingBlocState> {
  SellingBloc() : super(LoadingProductSellingRecords()) {
    const int perPage = 10;
    final SellingService _service = SellingService();

    int _currentPage = 1;
    bool _isEnd = false;

    DateTime? _start;
    DateTime? _end;

    List<InvoiceModel> _records = [];

    void _clear() {
      _records.clear();
      _currentPage = 1;
      _isEnd = false;
      _start = null;
      _end = null;
    }

    Future<void> _loadMore() async {
      try {
        if (_isEnd) return;

        if (_start != null && _end != null) {
          // todo here fetch in this range
        }


        // fetch
        final res = await _service.getProductsSellingRecords(_currentPage++);
        _records.addAll(res);
        if (res.length < perPage) {
          _isEnd = true;
        }
      } catch (e) {
        print(e);
      }
    }

    Future<void> _onLoad(LoadProductSellingRecords event, emit) async {
      try {
        if (_isEnd) {
          return;
        }
        if (_currentPage <= 1) {
          emit(LoadingProductSellingRecords());
        }
        // laod more
        await _loadMore();

        return emit(GotSellingProductsRecords(
            records: List.from(_records), isEnd: _isEnd));
      } catch (e) {
        emit(FailedToLoadSellignRecords());
      }
    }

    Future<void> _onReload(ReloadProductSellingRecords event, emit) async {
      try {
        _clear(); 
        emit(LoadingProductSellingRecords());

        // laod more
        await _loadMore();

        return emit(GotSellingProductsRecords(
          records: List.from(_records),
          isEnd: _isEnd,
        ));
      } catch (e) {
        emit(FailedToLoadSellignRecords());
      }
    }

    Future<void> _onLoadInRange(LoadSellingRecordsInRange event, emit) async {
      try {
        if (_end == null || _start == null) {
          _clear();
          emit(LoadingProductSellingRecords());
        }
        _end = event.end;
        _start = event.start;

        // laod more
        await _loadMore();

        return emit(GotSellingProductsRecords(
          records: List.from(_records),
          isEnd: _isEnd,
          end: _end,
          start: _start,
        ));
      } catch (e) {
        emit(FailedToLoadSellignRecords());
      }
    }

    // event listeners
    on<LoadProductSellingRecords>(_onLoad);

    on<ReloadProductSellingRecords>(_onReload);

    on<LoadSellingRecordsInRange>(_onLoadInRange);

    // todo : impelemnt on sell item
  }
}
