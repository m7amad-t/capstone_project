part of 'buying_products_bloc_bloc.dart';

sealed class BuyingProductsBlocState extends Equatable {
  const BuyingProductsBlocState();
  
  @override
  List<Object> get props => [];
}


final class FailedToLoadProductsBoughtHistory extends BuyingProductsBlocState{}

final class LoadingBoughtForProducts extends BuyingProductsBlocState {}

final class GotProductsBoughtHistory extends BuyingProductsBlocState {
  final List<ProductBoughtModel> records;
  final DateTimeRange? range;
  final bool ended;
  const GotProductsBoughtHistory({
    required this.records,
    required this.range,
    this.ended = false,
  });

  @override
  List<Object> get props => [records,  range ?? "", ended];
}