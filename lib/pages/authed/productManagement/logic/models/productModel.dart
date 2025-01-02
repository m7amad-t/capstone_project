import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {

  final String name;
  final double price;
  final String imageUrl; 
  final String description;
  final int  quantity;


  const ProductModel({required this.name, required this.price, required this.imageUrl, required this.description, required this.quantity}); 



  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      quantity: json['quantity'],
    );
  }

  // to Map
  Map<String, dynamic> toJsonMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'quantity': quantity,
    };
  }

  // to json
  String get  toJson {
    return jsonEncode(toJsonMap); 
  }

    
  @override
  String toString() {
    return """

---------- product -------------
 Name: $name
 Price: $price
 Image: $imageUrl
 Description: $description
 Quantity: $quantity
 -------------------------------

"""; 
  }
  
  @override
  List<Object?> get props => [name , price , imageUrl , description , quantity];

}