part of 'buying_products_bloc_bloc.dart';

sealed class BuyingProductsBlocEvent extends Equatable {
  const BuyingProductsBlocEvent();

  @override
  List<Object> get props => [];
}


class LoadBoughtHistory extends BuyingProductsBlocEvent {
}

class ReloadBoughtHistory extends BuyingProductsBlocEvent {
}

class LoadBoughtHistoryInRange extends BuyingProductsBlocEvent {
  final DateTimeRange range;

  const LoadBoughtHistoryInRange({required this.range});


  @override
  List<Object> get props => [range];
}

class BoughtProduct extends BuyingProductsBlocEvent {

  final ProductBoughtModel record; 

  const BoughtProduct({
    required this.record, 
  });

  @override
  List<Object> get props => [
        record , 
      ];
}
