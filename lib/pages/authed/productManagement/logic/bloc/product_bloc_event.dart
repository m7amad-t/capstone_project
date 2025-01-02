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
        return context.translate.name_a_to_z;
      case ORDER_PRODUCT_BY.NAME_DESC:
        return context.translate.name_z_to_a;
      case ORDER_PRODUCT_BY.PRICE:
        return context.translate.price_high_to_low;
      case ORDER_PRODUCT_BY.PRICE_DESC:
        return context.translate.price_low_to_high;
      case ORDER_PRODUCT_BY.QUANTITY:
        return context.translate.quantity_high_to_low;
      case ORDER_PRODUCT_BY.QUANTITY_DESC:
        return context.translate.quantity_low_to_high;
      default:
        return context.translate.order_by_default;
    }
  }
}

class LoadProducts extends ProductBlocEvent {}

class ReloadProduct extends ProductBlocEvent {}

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