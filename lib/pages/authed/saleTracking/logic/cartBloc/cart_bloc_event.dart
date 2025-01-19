part of 'cart_bloc_bloc.dart';

sealed class CartBlocEvent extends Equatable {
  const CartBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartBlocEvent {
  const LoadCart();
}

class SetCostumQuantity extends CartBlocEvent {}

class AddItemToCart extends CartBlocEvent {
  final ProductModel product;
  final int? quantity;
  final BuildContext context ; 
  const AddItemToCart({
    required this.product,
    required this.context,
  
    this.quantity,
  });
  @override
  List<Object> get props => [
        product,
        quantity ?? 1,
      ];
}

class RemoveFromCart extends CartBlocEvent {
  final ProductModel product;

  const RemoveFromCart({
    required this.product,
  });

  @override
  List<Object> get props => [
        product,
      ];
}

class DecrementQuantity extends CartBlocEvent {
  final ProductModel product;

  const DecrementQuantity({
    required this.product,
  });

  @override
  List<Object> get props => [
        product,
      ];
}

class PlaceOrder extends CartBlocEvent {
  final BuildContext context;
  const PlaceOrder({required this.context});
}

class ProductUpdatedUpdateInCart extends CartBlocEvent {
  final ProductModel updatedProduct;

  const ProductUpdatedUpdateInCart({required this.updatedProduct});
}

class ProductListUpdatedCheckUpdates extends CartBlocEvent {
  final List<ProductModel> products;

  const ProductListUpdatedCheckUpdates({required this.products});
}

class ClearCart extends CartBlocEvent {
  const ClearCart();
}
