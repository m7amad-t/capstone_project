// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/cartLocalService.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/cardModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/uiHelper.dart';
part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBloc() : super(LoadingCart()) {
    List<CartModel> _cartData = [];

    Future<void> _loadCart() async {
      // check if there is any in local storage
      _cartData = await CartLocalService.loadFromLocal();
    }

    Future<void> _saveCart() async {
      // save to local storage
      await CartLocalService.saveCart(_cartData);
    }

    Future<void> _onLoadcart(LoadCart event, emit) async {
      emit(LoadingCart());
      await _loadCart();
      emit(
        GotCart(cartData: [..._cartData], isAllUpdated: true),
      );
    }

    Future<void> _onAddItemToCart(AddItemToCart event, emit) async {
      // get the item
      final ProductModel product = event.product;
     
   
      // check if product already in cart
      if(event.quantity != null){
        // get the quantity 
        int quantity = event.quantity ?? 0 ;

        if(quantity <= 0 ){
          for(int i = 0; i < _cartData.length ; i++){
            if(_cartData[i].product.id == product.id){
              // remove the item from the cart
              _cartData.removeAt(i);
              return emit(GotCart(isAllUpdated: true, cartData: [..._cartData])); 
            }
          }
        }
        // update quantity to the incomming quantity 
        if(quantity > product.quantity){
          showSnackBar(message: WarningSnackBar(title: "out of stok", message: "out of stok"));
          return emit(
            CartItemUpdated(
              updatedItem: product,
              cart: [..._cartData],
            ),
          );  
        }else {
          // find the cartModel 
          for(int i = 0 ; i<_cartData.length ;i++){
            if(_cartData[i].product.id == product.id){
              final temp = _cartData[i]; 
              _cartData.removeAt(i); 
              // add updaetd item to the cart
              _cartData.add(temp.copyWith({'quantity'  : quantity}));  
              return emit(CartItemUpdated(updatedItem: product, cart: [..._cartData])); 
            }
          }

        }
      }

      // check if product have quantity to sell
      if (product.quantity <= 0) {
        // show a snackbar
        showSnackBar(
            message: WarningSnackBar(
                title: "out of stock", message: "out of stock"));
        return;
      }

      for (int i = 0; i < _cartData.length; i++) {
        if (_cartData[i].product.id == product.id) {
          // check quantity
          if (_cartData[i].quantity >= product.quantity) {
            // show a snackbar
            showSnackBar(
                message: WarningSnackBar(
                    title: "Out of stock ",
                    message:
                        "this product have only ${product.quantity} in stock"));
            // already at max quantity, do nothing
            return;
          }

          // increment the quantity
          final temp = _cartData[i].increment();
          // remove old one
          _cartData.removeAt(i);
          // add new one
          _cartData.add(temp);

          await _saveCart();
          return emit(
            CartItemUpdated(
              updatedItem: event.product,
              cart: [..._cartData],
            ),
          );
        }
      }
      // create new cart model
      final CartModel newCartItem =
          CartModel(product: product, quantity: 1, discount: 0);
      // add to cart data
      _cartData.add(newCartItem);

      await _saveCart();

      return emit(
        GotCart(
          cartData: [..._cartData],
          isAllUpdated: true,
          updatedItem: event.product,
        ),
      );
    }

    Future<void> _onRemoveFromCart(RemoveFromCart event, emit) async {
      final ProductModel product = event.product;

      _cartData.removeWhere((element) => element.product.id == product.id);
      await _saveCart();
      return emit(GotCart(
          cartData: [..._cartData], updatedItem: product, isAllUpdated: false));
    }

    Future<void> _onDecrementQuantity(DecrementQuantity event, emit) async {
      final ProductModel product = event.product;

      for (int i = 0; i < _cartData.length; i++) {
        if (_cartData[i].product.id == product.id) {
          if (_cartData[i].quantity == 1) {
            _cartData.removeAt(i);
            await _saveCart();
            return emit(
              GotCart(
                cartData: [..._cartData],
                updatedItem: event.product,
                isAllUpdated: true,
              ),
            );
          }
          final temp= _cartData[i].dicrement();
          _cartData.removeAt(i); 
          _cartData.add(temp);
          await _saveCart();
          return emit(CartItemUpdated(
            cart: [..._cartData],
            updatedItem: event.product,
          ));
        }
      }
    }

    Future<void> _onClearCart(ClearCart event, emit) async {
      _cartData = [];
      await _saveCart();
      return emit(GotCart(cartData: [..._cartData], isAllUpdated: true));
    }

    Future<void> _onPlaceOrder(PlaceOrder event, emit) async {
      // check if cart is empty
      if (_cartData.isEmpty) {
        // show a snackbar
        showSnackBar(
            message: WarningSnackBar(
                title: "Cart is empty", message: "Add some items to cart"));
        return;
      }

      // show a snackbar
      showSnackBar(
          message: SuccessSnackBar(
              title: "Order placed", message: "Order placed successfully"));
      _cartData = [];
      await _saveCart();
      return emit(GotCart(cartData: [..._cartData], isAllUpdated: false));
    }

    // laod cart event listener
    on<LoadCart>(_onLoadcart);

    // add to cart event listener
    on<AddItemToCart>(_onAddItemToCart);

    // remove from cart event listener
    on<RemoveFromCart>(_onRemoveFromCart);

    // decrement event listener
    on<DecrementQuantity>(_onDecrementQuantity);

    // celar cart event listener
    on<ClearCart>(_onClearCart);

    // onPlace Order event listener
    on<PlaceOrder>(_onPlaceOrder);
  }
}
