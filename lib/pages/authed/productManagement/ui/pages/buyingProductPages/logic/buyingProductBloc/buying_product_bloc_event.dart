part of 'buying_product_bloc_bloc.dart';

sealed class BuyingProductBlocEvent extends Equatable {
  const BuyingProductBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadProductBoughtHistory extends BuyingProductBlocEvent {
  final ProductModel product;

  const LoadProductBoughtHistory({required this.product});

  @override
  List<Object> get props => [product];
}

class ReloadProductBoughtHistory extends BuyingProductBlocEvent {
  final ProductModel product;

  const ReloadProductBoughtHistory({required this.product});

  @override
  List<Object> get props => [product];
}

class LoadProductBoughtHistoryInRange extends BuyingProductBlocEvent {
  final ProductModel product;
  final DateTimeRange range;

  const LoadProductBoughtHistoryInRange({required this.product, required this.range}); 

  @override
  List<Object> get props => [product , product];
}

class BoughtProductInSingleProduct extends BuyingProductBlocEvent {

  final ProductModel product ; 
  final ProductBoughtModel record;
  final BuildContext context;

  const BoughtProductInSingleProduct({
    required this.product,
    required this.record, 
    required this.context, 
  });

  @override
  List<Object> get props => [
        product,
        record , 
        context, 
      ];
}
