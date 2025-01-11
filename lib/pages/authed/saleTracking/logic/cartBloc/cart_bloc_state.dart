part of 'cart_bloc_bloc.dart';

sealed class CartBlocState extends Equatable {
  final List<CartModel> cartData ;

  const CartBlocState({required this.cartData});
  
  @override
  List<Object> get props => [cartData];
}

final class LoadingCart extends CartBlocState {
  const LoadingCart({required super.cartData});
}


final class GotCart extends CartBlocState {
  final ProductModel? updatedItem ; 
  final bool isAllUpdated ; 
  const GotCart({ this.updatedItem,required this.isAllUpdated, required super.cartData , }); 

  @override
  List<Object> get props => [cartData , isAllUpdated,];
}


final class CartItemUpdated extends CartBlocState {
  final ProductModel updatedItem ; 

  const CartItemUpdated({required this.updatedItem , required super.cartData , }); 

  @override
  List<Object> get props => [updatedItem,cartData];
}
