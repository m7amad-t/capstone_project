part of 'expired_products_bloc_bloc.dart';

sealed class ExpiredProductsBlocState extends Equatable {
  const ExpiredProductsBlocState();
  
  @override
  List<Object> get props => [];
}

final class LoadingExpiredProducts extends ExpiredProductsBlocState {}

final class FailedToLoadExpiredProducts extends ExpiredProductsBlocState {}

final class GotExpiredProducts extends ExpiredProductsBlocState {

  final List<ExpiredProductModel> records;
  const GotExpiredProducts({required this.records }); 

  @override
  List<Object> get props => [records];

}


