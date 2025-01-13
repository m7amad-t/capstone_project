part of 'returned_product_bloc_bloc.dart';
sealed class ReturnedProductBlocEvent extends Equatable {
  // we need this so we can be able to send events to other blocs
  const ReturnedProductBlocEvent();

  @override
  List<Object> get props => [];
}

final class LoadReturnedProduct extends ReturnedProductBlocEvent {
  final ProductModel product;
  const LoadReturnedProduct({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

final class ReloadReturnedProduct extends ReturnedProductBlocEvent {
  final ProductModel product;
  const ReloadReturnedProduct({required this.product,});

  @override
  List<Object> get props => [product];
}

final class LoadReturnedProductInRange extends ReturnedProductBlocEvent {
  final ProductModel product;
  final int page;
  final DateTime start;
  final DateTime end;

  const LoadReturnedProductInRange({
    required this.product,
    this.page = 1,
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [ product, start, end, page];
}

final class FilterByReason extends ReturnedProductBlocEvent {
  final RETURN_PRODUCT_REASON? reason;

  const FilterByReason({
    required this.reason,
  });

  @override
  List<Object> get props => [ reason ?? RETURN_PRODUCT_REASON.UNKNOWN];
}

final class ReturnProduct extends ReturnedProductBlocEvent {
  final ProductReturnedModel product;
  final BuildContext context ; 
  const ReturnProduct({

    required this.product,
    required this.context,
  });

  @override
  List<Object> get props => [product , context];
}
