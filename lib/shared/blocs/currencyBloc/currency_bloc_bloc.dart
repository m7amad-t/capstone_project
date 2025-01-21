import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/models/storeCurrency.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/auth/cloudAuth.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'currency_bloc_event.dart';
part 'currency_bloc_state.dart';

class CurrencyBloc extends Bloc<CurrencyBlocEvent, CurrencyBlocState> {
  CurrencyBloc() : super(const GotCurrency(currency: STORE_CURRENCY.DOLLAR)) {
    Future<void> _onChangeCurrency(ChangeCurrency event, emit) async {
      locator<AppDialogs>()
          .showCostumTextLoading(event.context.translate.change_store_currency);

      await Future.delayed(const Duration(seconds: 1));

      final dum = locator<AuthedUser>();
      final updated = dum.update({
        'currency': event.newCurrency,
      });


      locator.unregister<AuthedUser>();
      locator.registerSingleton<AuthedUser>(updated);
      locator<AppDialogs>().disposeAnyActiveDialogs();
      final _service = CloudAuth(); 

      _service.changeCurrency(event.newCurrency , locator<AuthedUser>()); 
    

      emit(CurrencyChanged(currency: locator<AuthedUser>().currency));
    }

    on<ChangeCurrency>(_onChangeCurrency);
  }
}
