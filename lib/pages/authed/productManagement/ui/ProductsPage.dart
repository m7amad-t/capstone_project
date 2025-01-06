// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productCard.dart';
import 'package:shop_owner/router/extraTemplates/productManagementExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _showOrderOptions = false;
  late final TextEditingController _queryController;
  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
    context.read<ProductBloc>().add(LoadProducts());
  }

  Timer? _debounce;

  void _debounceSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ProductBloc>().add(SearchProductByName(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    // lock rotation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,      
    ]);


    final TextTheme _textStyle = Theme.of(context).textTheme;
    return BlocBuilder<ProductBloc, ProductBlocState>(
      builder: (context, state) {
 
        if (state is LoadingProducts) {
          return const Scaffold(
            body:  Center(
                child: RepaintBoundary(
              child: CircularProgressIndicator(),
            )),
          );
        }

        bool gotProductsAndHaveCategory =
            state is GotProducts && state.categories.isNotEmpty;

        return Scaffold(
          
          floatingActionButton: !gotProductsAndHaveCategory
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    GoRouter.of(context).push(
                      AppRoutes.productManagement
                      +"/"+
                      AppRoutes.product
                      +"/"+
                      AppRoutes.addProduct,
                      extra: AddNewProductExtra(categories: state.categories)
                          .getExtra,
                    );
                  },
                  child: const Icon(Icons.add),
                ),
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(ReloadProduct());
                _queryController.text = "";
              },
              child: gotProductsAndHaveCategory
                  ? _bestCase(context, state, _textStyle)
                  : state is FailedToLoad
                      ? _failed()
                      : state is GotProducts
                          ? _noCategory()
                          : Container(),
            ),
          ),
        );
      },
    );
  }

  Widget _noCategory() {
    return Center(
      child: Text(context.translate.no_data_found),
    );
  }

  Widget _failed() {
    return Expanded(
      child: Text(context.translate.error),
    );
  }

  Widget _bestCase(
      BuildContext context, ProductBlocState state, TextTheme _textStyle) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddings.p10,
      ),
      child: Column(
        children: [
          // search and filter section
          Expanded(
            child: _searchTextFieldSection(),
          ),

          // filter options
          if (_showOrderOptions)
            // filter section
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: locator<DynamicSizes>().p100,
                ),
                child: Container(
                  child: _orderByOptionSection(context, state),
                ),
              ),
            ),

          // filter section
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: locator<DynamicSizes>().p100,
              ),
              child: Container(
                margin: EdgeInsets.only(
                  bottom: AppSizes.s5,
                  top: AppSizes.s5,
                ),
                child: _productFilterSection(
                  context,
                  state,
                  _textStyle,
                ),
              ),
            ),
          ),

          // product section
          Expanded(
            flex: _showOrderOptions ? 9 : 10,
            child: Stack(
              children: [
                _productListSection(context, state),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor,
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.0),
                        ],
                      ),
                    ),
                    child: Container(
                      height: AppSizes.s50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchTextFieldSection() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: locator<DynamicSizes>().p70,
            ),
            child: TextField(
              controller: _queryController,
              onChanged: (query) {
                _debounceSearch(query);
              },
              decoration: InputDecoration(
                hintText: context.translate.search_for_items,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: AppSizes.s45,
                  maxWidth: AppSizes.s60,
                ),
                child: TextButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsetsDirectional.all(
                        AppPaddings.p10,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // show filter dialog
                    // showOrderOptionForProducts(context);
                    setState(() {
                      _showOrderOptions = !_showOrderOptions;
                    });
                  },
                  child: const Icon(
                    Icons.tune_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _orderByOptionSection(BuildContext context, ProductBlocState state) {
    final TextTheme _textStyle = Theme.of(context).textTheme;

    ORDER_PRODUCT_BY _initValue = ORDER_PRODUCT_BY.DEFAULT;
    if (state is GotProducts) {
      _initValue = state.orderby;
    }

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: AppSizes.s6,
            ),
            padding: EdgeInsets.symmetric(horizontal: AppSizes.s8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(AppSizes.s8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ORDER_PRODUCT_BY>(
                value: _initValue,
                items: [
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.DEFAULT,
                    child: Text(
                      context.translate.order_by_default,
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.NAME,
                    child: Text(
                      '${context.translate.name} ${context.translate.name_a_to_z}',
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.NAME_DESC,
                    child: Text(
                      '${context.translate.name} ${context.translate.name_z_to_a}',
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.PRICE,
                    child: Text(
                      context.translate.order_by_price,
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.PRICE_DESC,
                    child: Text(
                      '${context.translate.order_by_price} ${context.translate.price_low_to_high}',
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.QUANTITY,
                    child: Text(
                      '${context.translate.quantity} ${context.translate.quantity_high_to_low}',
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ORDER_PRODUCT_BY.QUANTITY_DESC,
                    child: Text(
                      '${context.translate.quantity} ${context.translate.quantity_low_to_high}',
                      style: _textStyle.bodyMedium,
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  context.read<ProductBloc>().add(OrderBy(value));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _productFilterSection(
    BuildContext context,
    ProductBlocState state,
    final TextTheme _textStyle,
  ) {
    if (state is GotProducts) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // cuz we wraped the product list we add trailing gap
        itemCount: state.categories.length + 1,
        itemBuilder: (context, index) {
          ProductCategoryModel? _selectedcategory = state.selectedCategory;

          if (index < state.categories.length) {
            final ProductCategoryModel category = state.categories[index];
            // check if category is the one how selected

            final bool isMeHowSelected = _selectedcategory == null
                ? false
                : _selectedcategory.name == category.name;

            return Container(
              margin: EdgeInsets.only(right: AppSizes.s10),
              child: TextButton(
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    isMeHowSelected
                        ? null
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsetsDirectional.symmetric(
                      horizontal: AppPaddings.p6,
                      vertical: AppPaddings.p8,
                    ),
                  ),
                ),
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(SelectCategory(category: state.categories[index]));
                },
                child: Text(
                  state.categories[index].name,
                  style: _textStyle.bodySmall!.copyWith(
                    color: isMeHowSelected ? AppColors.onPrimary : null,
                  ),
                ),
              ),
            );
          }
          // all button
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppSizes.s10,
            ),
            child: TextButton(
              style: ButtonStyle(
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  _selectedcategory == null
                      ? null
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsetsDirectional.symmetric(
                    horizontal: AppPaddings.p6,
                    vertical: AppPaddings.p8,
                  ),
                ),
              ),
              onPressed: () {
                context.read<ProductBloc>().add(LoadProducts());
              },
              child: Text(
                context.translate.all,
                style: _textStyle.bodySmall!.copyWith(
                  color: _selectedcategory == null ? AppColors.onPrimary : null,
                ),
              ),
            ),
          );
        },
      );
    }
    return const SizedBox();
  }

  Widget _productListSection(BuildContext context, ProductBlocState state) {
    if (state is FailedToLoad) {
      return Center(
        child: Text(context.translate.enter_password),
      );
    }

    if (state is LoadingProducts) {
      return const Center(
        child: RepaintBoundary(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // list of products to display
    List<ProductModel> products = [];

    // list of product categories to display
    List<ProductCategoryModel> categories = [];

    if (state is GotProducts) {
      products = state.products;
      categories = state.categories;
    }

    if (categories.isEmpty) {
      return Center(
        child: Text(context.translate.no_data_found),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      // cuz we wraped the product list we add trailing gap
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            //top margin
            top: index == 0 ? AppSizes.s30 : AppSizes.s10,

            // trailing gap
            bottom: index == products.length - 1 ? AppSizes.s150 : 0,
          ),
          child: ProductCard(
            product: products[index],
            categories: categories,
          ),
        );
      },
    );
  }
}
