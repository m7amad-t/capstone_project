// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/buyingProductsBloc/buying_products_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/service/productBoughtService.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

part 'buying_product_bloc_event.dart';
part 'buying_product_bloc_state.dart';

class BuyingProductBloc
    extends Bloc<BuyingProductBlocEvent, BuyingProductBlocState> {
  BuyingProductBloc() : super(LoadingBoughtForProduct()) {
    final ProductBoughtServcie _service = ProductBoughtServcie();

    List<ProductBoughtModel> _records = [];
    ProductModel? _lastProduct;
    DateTimeRange? _lastRange;
    int _currentPage = 1;
    bool _isEnded = false;

    void _clear() {
      _lastProduct = null;
      _lastRange = null;
      _isEnded = false;
      _records.clear();
      _currentPage = 1;
    }

    Future<void> _loadMore() async {
      print('---------------------------'); 
      final res = await _service.getListFromJson(_currentPage++);
      if (res.length < _service.perPage) {
        _isEnded = true;
      }

      print(res); 
      print(res.length); 

      _records.addAll(res);
    }

    Future<void> _onLoad(LoadProductBoughtHistory event, emit) async {
      // if all records have been loaded
      if (_isEnded) {
        emit(
          GotProductBoughtHistory(
            records: _records,
            product: _lastProduct!,
            range: _lastRange,
            ended: _isEnded,
          ),
        );
      }

      // check if last product is Null
      if (_lastProduct == null) {
        _clear();
        _lastProduct = event.product;
        emit(LoadingBoughtForProduct());
      }

      // load records
      await _loadMore();

      emit(
        GotProductBoughtHistory(
          records: _records,
          product: _lastProduct!,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    Future<void> _onReload(ReloadProductBoughtHistory event, emit) async {
      _clear();

      emit(LoadingBoughtForProduct());

      // load records
      await _loadMore();

      emit(
        GotProductBoughtHistory(
          records: _records,
          product: _lastProduct!,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    Future<void> _onLoadInRange(
      LoadProductBoughtHistoryInRange event,
      emit,
    ) async {
      if (_lastRange == null) {
        _clear();
        emit(LoadingBoughtForProduct());
      }

      if (_isEnded) {
        return emit(GotProductBoughtHistory(
          records: _records,
          product: _lastProduct!,
          range: _lastRange,
          ended: _isEnded,
        ));
      }

      // load records
      await _loadMore();

      emit(
        GotProductBoughtHistory(
          records: _records,
          product: _lastProduct!,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    Future<void> _onBoughtProduct(
      BoughtProductInSingleProduct event,
      emit,
    ) async {

      locator<AppDialogs>().showCostumTextLoading('Buying Product..');

      Future.delayed(const Duration(seconds: 1));

      _records.add(event.record);

      // notfiy other blocs
      event.context.read<ProductBloc>().add(
            ReturnProductToInventory(
              product: event.product,
              quantity: event.record.quantity,
            ),
          );

      event.context.read<BuyingProductsBloc>().add(
            BoughtProduct(
              record: event.record,
            ),
          );

      locator<AppDialogs>().disposeAnyActiveDialogs();

      showSnackBar(
          message: SuccessSnackBar(
              title: "Bought product successfuly",
              message: "Bought product successfuly"));

      GoRouter.of(event.context)
          .go("${AppRoutes.productManagement}/${AppRoutes.buyProducts}");

      emit(
        GotProductBoughtHistory(
          records: _records,
          product: _lastProduct!,
          range: _lastRange,
          ended: _isEnded,
        ),
      );
    }

    // event listeners..

    on<LoadProductBoughtHistory>(_onLoad);

    on<ReloadProductBoughtHistory>(_onReload);

    on<LoadProductBoughtHistoryInRange>(_onLoadInRange);

    on<BoughtProductInSingleProduct>(_onBoughtProduct);
  }
}
