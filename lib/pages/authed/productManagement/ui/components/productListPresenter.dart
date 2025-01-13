// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/ProductFilterSection.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/ProductListViewTopShadow.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productsOrderBySection.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productCard.dart';
import 'package:shop_owner/router/extraTemplates/productManagementExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductListPresenter extends StatefulWidget {
  final String cardPath;
  final bool isCardTappable;
  final bool floatingButton;
  final Widget? insertTop ; 
  const ProductListPresenter({
    super.key,
    required this.cardPath,
    this.insertTop,
    this.isCardTappable = false,
    this.floatingButton = false,
  });

  @override
  State<ProductListPresenter> createState() => _ProductListPresenterState();
}

class _ProductListPresenterState extends State<ProductListPresenter> {
  bool _showOrderOptions = false;
  late final TextEditingController _queryController;
  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
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

    final TextTheme _textStyle = Theme.of(context).textTheme;
    return BlocConsumer<ProductBloc, ProductBlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingProducts) {
          return const Scaffold(
            body: Center(
              child: RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        bool gotProductsAndHaveCategory =
            state is GotProducts && state.categories.isNotEmpty;
        if (state is GotProducts) {
          _queryController.text = state.lastQuery;
        }

        return Scaffold(
          floatingActionButton: !gotProductsAndHaveCategory
              ? null
              : !widget.floatingButton
                  ? null
                  : FloatingActionButton(
                      onPressed: () {
                        GoRouter.of(context).push(
                          AppRoutes.productManagement +
                              "/" +
                              AppRoutes.product +
                              "/" +
                              AppRoutes.addProduct,
                          extra:
                              AddNewProductExtra(categories: state.categories)
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
                context
                    .read<ProductBloc>()
                    .add(ReloadProduct(context: context));
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
    return const Center(
      child: Text("Not category "),
    );
  }

  Widget _failed() {
    return const Expanded(
      child: Text("Failed to load"),
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

          widget.insertTop ?? const SizedBox(), 

          // search and filter section
          Expanded(
            child: _searchTextFieldSection(),
          ),

          // filter options
          if (_showOrderOptions)
            // filter section
            const Expanded(
              child: ProductOrderOptionSection(),
            ),

          // filter section
          const Expanded(
            child: ProductFilterSection(),
          ),

          // product section
          Expanded(
            flex: _showOrderOptions ? 9 : 10,
            child: Stack(
              children: [
                _productListSection(context, state),
                // top shadow
                const ProductListTopShadow()
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
                  child: filterIcon(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
            onTapCallback: !widget.isCardTappable
                ? null
                : () {
                    GoRouter.of(context).push(
                      widget.cardPath,
                      extra: UpdateProductExtra(
                        categories: categories,
                        product: products[index],
                      ).getExtra,
                    );
                  },
            isReturnPageCard: widget.isCardTappable,
            product: products[index],
            categories: categories,
          ),
        );
      },
    );
  }
}
