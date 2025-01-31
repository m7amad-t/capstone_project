import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final int quantity;

  const ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.description,
      required this.quantity});

  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      quantity: json['quantity'],
    );
  }

  // from json
  factory ProductModel.fromJsonBasicData(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['description'] ?? "",
      quantity: json['quantity'] ?? -1,
    );
  }

  // to Map
  Map<String, dynamic> toJsonMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'quantity': quantity,
    };
  }

  ProductModel update(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] ?? id,
      name: data['name'] ?? name,
      price: data['price'] ?? price,
      imageUrl: data['imageUrl'] ?? imageUrl,
      description: data['description'] ?? description,
      quantity: data['quantity'] ?? quantity,
    );
  }

  // to json
  String get toJson {
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
  List<Object?> get props => [id, name, price, imageUrl, description, quantity];
}
