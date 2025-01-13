part of 'buying_product_bloc_bloc.dart';

sealed class BuyingProductBlocState extends Equatable {
  const BuyingProductBlocState();

  @override
  List<Object> get props => [];
}

final class LoadingBoughtForProduct extends BuyingProductBlocState {}

final class FailedToLoadProductBoughtHistory extends BuyingProductBlocState {}

final class GotProductBoughtHistory extends BuyingProductBlocState {
  final List<ProductBoughtModel> records;
  final ProductModel product;
  final DateTimeRange? range;
  final bool ended;
  const GotProductBoughtHistory({
    required this.records,
    required this.product,
    required this.range,
    this.ended = false,
  });

  @override
  List<Object> get props => [records, product, range ?? "", ended];
}
