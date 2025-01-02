part of 'product_bloc_bloc.dart';

sealed class ProductBlocState extends Equatable {
  const ProductBlocState();

  @override
  List<Object> get props => [];
}

class LoadingProducts extends ProductBlocState {}

class FailedToLoad extends ProductBlocState {}

class GotProducts extends ProductBlocState {
  final List<ProductCategoryModel> categories;
  final List<ProductModel> products;
  final ORDER_PRODUCT_BY orderby;
  final ProductCategoryModel? selectedCategory ; 

  const GotProducts({required this.orderby,required this.selectedCategory, required this.categories , required this.products});

  @override
  List<Object> get props => [categories , products ,  orderby  ,selectedCategory ?? [] ];
}

