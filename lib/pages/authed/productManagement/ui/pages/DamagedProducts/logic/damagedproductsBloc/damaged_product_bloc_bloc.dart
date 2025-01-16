// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/DamagedProductsModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/service/damagedProductsService.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'damaged_product_bloc_event.dart';
part 'damaged_product_bloc_state.dart';

class DamagedProductBloc
    extends Bloc<DamagedProductBlocEvent, DamagedProductBlocState> {
  DamagedProductBloc() : super(LoadingDamagedProducts()) {
    final DamagedProductsService service = DamagedProductsService();
    List<DamagedProductsModel> records = [];
    bool isEnded = false;
    DateTimeRange? lastRange;
    int currentPage = 1;

    void clear() {
      records.clear();
      currentPage = 1;
      lastRange = null;
      isEnded = false;
    }

    Future<void> loadMore() async {
      if (isEnded) {
        return;
      }

      final res = await service.getDamagedProducts(currentPage++);

      if (res.length < service.perPage) {
        isEnded = true;
      }

      if (currentPage == 4) {
        isEnded = true;
      }

      records.addAll(res);

      return;
    }

    Future<void> onLoad(LoadDamagedProducts event, emit) async {
      if (records.isEmpty) {
        clear();
        emit(LoadingDamagedProducts());
      }

      if (isEnded) {
        return;
      }

      await loadMore();

      emit(GotDamagedProducts(
        records: List.of([...records]),
        lastRange: lastRange,
        isEnded: isEnded,
      ));
    }

    Future<void> onReload(ReloadDamaegdProducts event, emit) async {
      clear();

      emit(LoadingDamagedProducts());

      await loadMore();

      emit(GotDamagedProducts(
        records: List.of([...records]),
        lastRange: lastRange,
        isEnded: isEnded,
      ));
    }

    Future<void> onLoadInRange(LoadDamagedProductInRange event, emit) async {
      if (records.isEmpty || lastRange == null) {
        clear();
        emit(LoadingDamagedProducts());
        lastRange = event.range;
      }

      if (lastRange!.start != event.range.start ||
          lastRange!.end != event.range.end) {
        clear();
        emit(LoadingDamagedProducts());
      }
      lastRange = event.range;

      await loadMore();

      emit(GotDamagedProducts(
        records: List.of([...records]),
        lastRange: lastRange,
        isEnded: isEnded,
      ));
    }

    Future<void> onAddDamagedProduct(AddProductToDamaged event, emit) async {
      records.insert(0, event.record);

      // if its not removed from the inventory remove it ...
      if (!event.returned) {
        // show loading dialog
        locator<AppDialogs>().showCostumTextLoading(
          event.context.translate.moving_to_damaged_inventory,
        );

        // simulate sending request
        await Future.delayed(const Duration(seconds: 1));

        // show message
        showSnackBar(
          message: SuccessSnackBar(
            title: event.context.translate.add_to_damaged_inventoy,
            message: event.context.translate.add_to_damaged_inventoy,
          ),
        );
        event.context.read<ProductBloc>().add(
              ReturnProductToInventory(
                product: event.record.product,
                quantity: -(event.record.quantity),
              ),
            );
        locator<AppDialogs>().disposeAnyActiveDialogs();
        GoRouter.of(event.context).pop();
      }

      emit(GotDamagedProducts(
        records: List.of([...records]),
        lastRange: lastRange,
        isEnded: isEnded,
      ));
    }

    // event listeners

    on<LoadDamagedProducts>(onLoad);

    on<ReloadDamaegdProducts>(onReload);

    on<LoadDamagedProductInRange>(onLoadInRange);

    on<AddProductToDamaged>(onAddDamagedProduct);
  }
}
