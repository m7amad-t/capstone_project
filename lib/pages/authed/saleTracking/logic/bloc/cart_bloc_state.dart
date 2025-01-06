part of 'cart_bloc_bloc.dart';

sealed class CartBlocState extends Equatable {
  const CartBlocState();
  
  @override
  List<Object> get props => [];
}

final class LoadingCart extends CartBlocState {}


final class GotCart extends CartBlocState {
  final List<CartModel> cartData ;
  final ProductModel? updatedItem ; 
  final bool isAllUpdated ; 
  const GotCart({ this.updatedItem,required this.isAllUpdated, required this.cartData}); 

  @override
  List<Object> get props => [cartData , isAllUpdated,];
}


final class CartItemUpdated extends CartBlocState {
  final ProductModel updatedItem ; 
  final List<CartModel> cart; 
  const CartItemUpdated({required this.updatedItem , required this.cart}); 

  @override
  List<Object> get props => [updatedItem,cart];
}
