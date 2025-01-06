import 'package:equatable/equatable.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';

class CartModel extends Equatable{

  final ProductModel product; 

  final int quantity;
  final int discount ; 


  const CartModel({
    required this.product,
    required this.quantity,
    required this.discount,
  });


  // to map format 
  Map<String, dynamic> toJsonMap() {
    return {
      'product': product.toJsonMap(),
      'quantity': quantity,
      'discount': discount,
    };
  }
  
  static List<CartModel> listFromMap (Map<String , dynamic> data){

    List<CartModel> cartData = [];

    for(final item in data['cart']){
      cartData.add(CartModel.fromJson(item));
    }

    return cartData;

  }

  static Map<String , dynamic> listToMap (List<CartModel> cart){

    List<Map<String , dynamic>> cartData = [];

    for(final item in cart){
      cartData.add(item.toJsonMap());
    }

    return {
      'cart' : cartData
    };

  }

  // from map
   CartModel copyWith(Map<String , dynamic> newData){
    return CartModel(
      product: newData['product'] ?? product,
      quantity: newData['quantity'] ?? quantity,
      discount: newData['discount'] ?? discount,
    );
  }

  // from map
   CartModel increment(){
    return CartModel(
      product: product,
      quantity: quantity+1,
      discount: discount,
    );
  }
  
  // from map
   CartModel dicrement(){
    return CartModel(
      product: product,
      quantity: quantity-1,
      discount: discount,
    );
  }
 
  // from map
   CartModel setDiscount(int discount){
    return CartModel(
      product: product,
      quantity: quantity,
      discount: discount,
    );
  }

  // from map
  factory CartModel.fromJson(Map<String, dynamic> data){
    return CartModel(
      product: ProductModel.fromJson(data['product']),
      quantity: data['quantity'],
      discount: data['discount'],
    );
  }

  @override
  List<Object?> get props => [product , quantity , discount];


  @override
  String toString() {
    
    return """

-----------------

Product: ${product.name}
Quantity: $quantity
Discount: $discount

-----------------

"""; 
  }
}