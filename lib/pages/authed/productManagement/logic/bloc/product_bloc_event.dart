// ignore_for_file: camel_case_types, constant_identifier_names

part of 'product_bloc_bloc.dart';

sealed class ProductBlocEvent extends Equatable {
  const ProductBlocEvent();

  @override
  List<Object> get props => [];
}

enum ORDER_PRODUCT_BY {
  DEFAULT,
  NAME,
  NAME_DESC,
  PRICE,
  PRICE_DESC,
  QUANTITY,
  QUANTITY_DESC,
}

extension ProductEnumExtension on ORDER_PRODUCT_BY {
  String name(BuildContext context) {
    switch (this) {
      case ORDER_PRODUCT_BY.NAME:
        return "context.translate.name_a_to_z";
      case ORDER_PRODUCT_BY.NAME_DESC:
        return "context.translate.name_z_to_a";
      case ORDER_PRODUCT_BY.PRICE:
        return "context.translate.price_high_to_low";
      case ORDER_PRODUCT_BY.PRICE_DESC:
        return "context.translate.price_low_to_high";
      case ORDER_PRODUCT_BY.QUANTITY:
        return "context.translate.quantity_high_to_low";
      case ORDER_PRODUCT_BY.QUANTITY_DESC:
        return "context.translate.quantity_low_to_high";
      default:
        return "context.translate.order_by_default";
    }
  }
}

class LoadProducts extends ProductBlocEvent {}

class ReloadProduct extends ProductBlocEvent {
  final BuildContext context ; 
  const ReloadProduct({required this.context});
}

class OrderBy extends ProductBlocEvent {
  final ORDER_PRODUCT_BY order;
  const OrderBy(this.order);

  @override
  List<Object> get props => [order];
}

class SelectCategory extends ProductBlocEvent {
  final ProductCategoryModel category;

  const SelectCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class SelectAll extends ProductBlocEvent {}

class SearchProductByName extends ProductBlocEvent {
  final String query;

  const SearchProductByName({required this.query});

  @override
  List<Object> get props => [query];
}

class UpdateProduct extends ProductBlocEvent {
  final ProductModel product;
  final Map<String, dynamic> toUpdate;
  final BuildContext context;
  final bool fromCart ; 
  const UpdateProduct({
    required this.product,
    required this.toUpdate,
    required this.context,
    this.fromCart = false, 
  });

  @override
  List<Object> get props => [product, toUpdate];
}

class DeleteProduct extends ProductBlocEvent {
  final ProductModel product;

  const DeleteProduct({required this.product});

  @override
  List<Object> get props => [product];
}

class InsertProduct extends ProductBlocEvent {
  final ProductModel product;
  final ProductCategoryModel category;

  const InsertProduct({required this.product, required this.category});

  @override
  List<Object> get props => [product];
}

class InsertCategory extends ProductBlocEvent {
  final ProductCategoryModel category;

  const InsertCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class UpdateCategory extends ProductBlocEvent {
  final ProductCategoryModel category;
  final Map<String, dynamic> update;

  const UpdateCategory({required this.category, required this.update});

  @override
  List<Object> get props => [category, update];
}

class DeleteCategory extends ProductBlocEvent {
  final ProductCategoryModel category;

  const DeleteCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class ReturnProductToInventory extends ProductBlocEvent {
  final ProductModel product;
  final int quantity;

  const ReturnProductToInventory({
    required this.product,
    required this.quantity,
  });
  @override
  List<Object> get props => [product, quantity];
}
