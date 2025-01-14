part of 'damaged_product_bloc_bloc.dart';

sealed class DamagedProductBlocState extends Equatable {
  const DamagedProductBlocState();

  @override
  List<Object> get props => [];
}

final class LoadingDamagedProducts extends DamagedProductBlocState {}

final class FailedToLoadDamagedProducts extends DamagedProductBlocState {}

final class GotDamagedProducts extends DamagedProductBlocState {
  final List<DamagedProductsModel> records;
  final DateTimeRange? lastRange;
  final bool isEnded ; 

  const GotDamagedProducts({
    required this.records,
    required this.lastRange,
    required this.isEnded,
  });


  @override
  List<Object> get props =>[records, lastRange ?? []];

}


