import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/shared/blocs/currencyBloc/currency_bloc_bloc.dart';
import 'package:shop_owner/shared/models/storeCurrency.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class PriceWidget extends StatelessWidget {
  final double? price;
  final TextStyle style;
  const PriceWidget({
    super.key,
    required this.price,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyBlocState>(
      builder: (context, state) {
        if(price == null){
        return Text("${locator<AuthedUser>().currency.sign}??" , style: style,); 
        }
        if(context.fromLTR){
        return Text("${locator<AuthedUser>().currency.sign} ${price!.toStringAsFixed(2)}" , style: style,); 

        }
        return Text("${price!.toStringAsFixed(2)} ${locator<AuthedUser>().currency.sign}" , style: style,); 
      },
    );
  }
}
