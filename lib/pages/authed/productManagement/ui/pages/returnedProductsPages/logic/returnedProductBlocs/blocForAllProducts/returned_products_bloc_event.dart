part of 'returned_products_bloc_bloc.dart';

sealed class ReturnedProductsBlocEvent extends Equatable {
  // we need this so we can be able to send events to other blocs
  final BuildContext context ; 
  const ReturnedProductsBlocEvent({required this.context});

  @override
  List<Object> get props => [];
}

final class LoadReturnedRecordsForAll extends ReturnedProductsBlocEvent {
  const LoadReturnedRecordsForAll({
    required super.context,
  });
}

final class ReloadReturnedRecordsForAll extends ReturnedProductsBlocEvent {
  const ReloadReturnedRecordsForAll({required super.context});
}

final class LoadReturnedRecordsForAllInRange extends ReturnedProductsBlocEvent {
  final DateTime start;
  final DateTime end;
  const LoadReturnedRecordsForAllInRange({
    required super.context,
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [context , start , end ];
}

final class FilterByReason extends ReturnedProductsBlocEvent {
  final RETURN_PRODUCT_REASON? reason;

  const FilterByReason({
    required super.context,
    required this.reason,
  });

  @override
  List<Object> get props => [context, reason ?? []];
}

final class FilterByReturnedPlace extends ReturnedProductsBlocEvent {
  final bool? retunedToInvenotory; 

  const FilterByReturnedPlace({
    required super.context,
    required this.retunedToInvenotory,
  });

  @override
  List<Object> get props => [context, retunedToInvenotory ?? []];
}


final class ReturnToReturnedProducts extends ReturnedProductsBlocEvent {
  final ProductReturnedModel record;

  const ReturnToReturnedProducts({required super.context, required this.record}); 

  @override
  List<Object> get props => [context, record];
}


