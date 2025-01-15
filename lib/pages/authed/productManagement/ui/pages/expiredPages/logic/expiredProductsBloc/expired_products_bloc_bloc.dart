// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/damagedproductsBloc/damaged_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/DamagedProductsModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/models/expiredProductModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/service/expiredProductService.dart';

part 'expired_products_bloc_event.dart';
part 'expired_products_bloc_state.dart';

class ExpiredProductsBloc
    extends Bloc<ExpiredProductsBlocEvent, ExpiredProductsBlocState> {
  ExpiredProductsBloc() : super(LoadingExpiredProducts()) {
    final ExpiredProductService _service = ExpiredProductService();

    List<ExpiredProductModel> _records = [];
    // DateTimeRange? _lastRange;
    bool isEnded = false;
    int _currentPage = 1;

    _clear() {
      _records.clear();
      // _lastRange = null;
      isEnded = false;
    }

    Future<void> _laodMore() async {
      if (isEnded) {
        return;
      }

      final newRecords = await _service.getExpiredProducts(_currentPage++);

      if (newRecords.length < _service.perPage) {
        isEnded = true;
      }

      _records.addAll(newRecords);
    }

    Future<void> _onLoad(LoadExpiredProducts event, emit) async {
      if (isEnded) {
        return;
      }

      if(_records.isEmpty){
        emit(LoadingExpiredProducts()); 
      }

      await _laodMore();

      List<ExpiredProductModel> result = List.from(_records);

      return emit(GotExpiredProducts(
        records: result,
      ));
    }

    Future<void> _onReload(ReloadExpiredProducts event, emit) async {
      emit(LoadingExpiredProducts());
      _clear();

      await _laodMore();

      return emit(GotExpiredProducts(
        records: List.from(_records),
      ));
    }

    Future<void> _onGitRidOfExpiredProduct(
      GetRidOfExpiredProduct event,
      emit,
    ) async {
      final record = event.record;

      // remove it from here..
      _records.removeWhere((element) => element.id == record.id);

      // notify other blocs

      // put it into damaged
      final damagedObj = DamagedProductsModel(
        id: -1,
        quantity: record.quantity,
        boughtedPrice: record.boughtedFor,
        product: record.product,
        note: "Item Expired, Added by The system",
        dateTime: DateTime.now(),
      );

      event.context.read<DamagedProductBloc>().add(
            AddProductToDamaged(
              record: damagedObj,
              context: event.context,
              returned: false,
            ),
          );

      List<ExpiredProductModel> result = List.from(_records);

      return emit(GotExpiredProducts(
        records: result,
      ));
    }

    // event listeners

    on<LoadExpiredProducts>(_onLoad);

    on<ReloadExpiredProducts>(_onReload);

    on<GetRidOfExpiredProduct>(_onGitRidOfExpiredProduct);
  }
}
