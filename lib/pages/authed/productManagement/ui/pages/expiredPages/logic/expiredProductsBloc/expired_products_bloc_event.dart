part of 'expired_products_bloc_bloc.dart';

sealed class ExpiredProductsBlocEvent extends Equatable {
  const ExpiredProductsBlocEvent();

  @override
  List<Object> get props => [];
}



final class  LoadExpiredProducts extends ExpiredProductsBlocEvent {
} 

final class  ReloadExpiredProducts extends ExpiredProductsBlocEvent {
} 



final class GetRidOfExpiredProduct extends ExpiredProductsBlocEvent {

  final ExpiredProductModel record ;
  final BuildContext context ; 

  const GetRidOfExpiredProduct({required this.record , required this.context});


  @override
  List<Object> get props => [record , context];

} 



