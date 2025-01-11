part of 'selling_bloc_bloc.dart';

sealed class SellingBlocEvent extends Equatable {
  const SellingBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadProductSellingRecords extends SellingBlocEvent {
  @override
  List<Object> get props => [];
}

class ReloadProductSellingRecords extends SellingBlocEvent {
  @override
  List<Object> get props => [];
}

class LoadSellingRecordsInRange extends SellingBlocEvent {

  final DateTime start ; 
  final DateTime end;

  const LoadSellingRecordsInRange({required this.start, required this.end}); 
  @override
  List<Object> get props => [end  , start];
}

class SellProduct extends SellingBlocEvent {
  final BuildContext context;
  final ProductModel product;
  final int quantity;
  final double? total; 

  const SellProduct({
    required this.product,
    required this.quantity,
    required this.context,
    this.total,
  });

  @override
  List<Object> get props => [product, quantity , total ?? 0.0];
}
