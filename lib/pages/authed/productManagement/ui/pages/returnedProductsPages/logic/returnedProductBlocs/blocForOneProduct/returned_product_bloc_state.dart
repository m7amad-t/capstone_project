part of 'returned_product_bloc_bloc.dart';


sealed class ReturnedProductBlocState extends Equatable {
  const ReturnedProductBlocState();

  @override
  List<Object> get props => [];
}


final class LoadingReturedProduct extends ReturnedProductBlocState {}

final class FailedToLoadProductReturnedRecords extends ReturnedProductBlocState {}

final class GotReturnedForProduct extends ReturnedProductBlocState {
  final List<ProductReturnedModel> records;
  final RETURN_PRODUCT_REASON? filter;
  final DateTime? start;
  final DateTime? end;
  final bool isLast ; 
  const GotReturnedForProduct(
      {required this.records,
      required this.filter,
      required this.start,
      required this.end,
      this.isLast = false, 
      });

  @override
  List<Object> get props => [
        records,
        start ?? [],
        end ?? [],
        filter ?? [],
        isLast,
      ];
}
