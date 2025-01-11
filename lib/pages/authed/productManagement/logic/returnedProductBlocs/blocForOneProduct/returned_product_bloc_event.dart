part of 'returned_product_bloc_bloc.dart';
sealed class ReturnedProductBlocEvent extends Equatable {
  // we need this so we can be able to send events to other blocs
  final BuildContext context;
  const ReturnedProductBlocEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class LoadReturnedProduct extends ReturnedProductBlocEvent {
  final ProductModel product;
  const LoadReturnedProduct({
    required this.product,
    required super.context,
  });

  @override
  List<Object> get props => [context, product];
}

final class ReloadReturnedProduct extends ReturnedProductBlocEvent {
  final ProductModel product;
  const ReloadReturnedProduct({required this.product, required super.context});

  @override
  List<Object> get props => [context, product];
}

final class LoadReturnedProductInRange extends ReturnedProductBlocEvent {
  final ProductModel product;
  final int page;
  final DateTime start;
  final DateTime end;

  const LoadReturnedProductInRange({
    required super.context,
    required this.product,
    this.page = 1,
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [context, product, start, end, page];
}

final class FilterByReason extends ReturnedProductBlocEvent {
  final RETURN_PRODUCT_REASON? reason;

  const FilterByReason({
    required super.context,
    required this.reason,
  });

  @override
  List<Object> get props => [context, reason ?? RETURN_PRODUCT_REASON.UNKNOWN];
}
