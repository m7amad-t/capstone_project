part of 'currency_bloc_bloc.dart';

sealed class CurrencyBlocEvent extends Equatable {
  const CurrencyBlocEvent();

  @override
  List<Object> get props => [];
}


class GetStoreCurrency extends CurrencyBlocEvent{}


class ChangeCurrency extends CurrencyBlocEvent{

  final STORE_CURRENCY newCurrency ;
  final BuildContext context ; 
  const ChangeCurrency({required this.newCurrency , required this.context}); 

  @override
  List<Object> get props => [newCurrency , context];
}
