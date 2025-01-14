part of 'damaged_product_bloc_bloc.dart';

sealed class DamagedProductBlocEvent extends Equatable {
  const DamagedProductBlocEvent();

  @override
  List<Object> get props => [];
}

final class LoadDamagedProducts extends DamagedProductBlocEvent {}

final class ReloadDamaegdProducts extends DamagedProductBlocEvent {}

final class LoadDamagedProductInRange extends DamagedProductBlocEvent {
  final DateTimeRange range;

  const LoadDamagedProductInRange({required this.range});

  @override
  List<Object> get props => [range];
}

final class AddProductToDamaged extends DamagedProductBlocEvent {
  final DamagedProductsModel record;
  final BuildContext context;
  //flag to indicate its sold and costumer returned now putting to damaged ,, cuz its already removed from inventory
  final bool returned;
  
  const AddProductToDamaged({
    required this.record,
    required this.context,
    this.returned = false,
  });

  @override
  List<Object> get props => [record, context , returned];
}
