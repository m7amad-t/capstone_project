part of 'returned_products_bloc_bloc.dart';

sealed class ReturnedProductsBlocState extends Equatable {
  const ReturnedProductsBlocState();
  
  @override
  List<Object> get props => [];
}

final class LoadingReturedProducts extends ReturnedProductsBlocState {}

final class FailedToLoadProductsReturnedRecords extends ReturnedProductsBlocState {}

final class GotReturnedForProducts extends ReturnedProductsBlocState {
  final List<ProductReturnedModel> records;
  final RETURN_PRODUCT_REASON? filter;
  final DateTime? start;
  final DateTime? end;
  final bool isLast ; 
  const GotReturnedForProducts(
      {required this.records,
      required this.filter,
      required this.start,
      required this.end,
      this.isLast = false, 
      });

  @override
  List<Object> get props => [
        ...super.props,
        records,
        start ?? [],
        end ?? [],
        filter ?? [],
        isLast,
      ];
}
