part of 'currency_bloc_bloc.dart';

sealed class CurrencyBlocState extends Equatable {
  const CurrencyBlocState();

  @override
  List<Object> get props => [];
}

final class GotCurrency extends CurrencyBlocState {
  final STORE_CURRENCY currency;

  const GotCurrency({required this.currency});

  @override
  List<Object> get props => [currency];
}

final class CurrencyChanged extends CurrencyBlocState {
  final STORE_CURRENCY currency;

  const CurrencyChanged({required this.currency});

  @override
  List<Object> get props => [currency];
}

