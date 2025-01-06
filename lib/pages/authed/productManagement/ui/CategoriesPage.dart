// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/router/extraTemplates/productManagementExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _textStyle = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: BlocBuilder<ProductBloc, ProductBlocState>(
        builder: (context, state) {
          List<ProductCategoryModel> categories = [];

          if (state is FailedToLoad || state is LoadingProducts) {
            return Container();
          }
          if (state is GotProducts) {
            categories = state.categories;
          }

          return FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push(
                '${AppRoutes.productManagement}/${AppRoutes.category}/${AppRoutes.addCategory}',
                extra: AddNewCategoryExtra(categories: categories).getExtra,
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
   
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10,
        ),
        child: BlocBuilder<ProductBloc, ProductBlocState>(
          builder: (context, state) {
            if (state is LoadingProducts) {
              return const RepaintBoundary(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is GotProducts) {
              if (state.categories.isEmpty) {
                return Text(
                  context.translate.no_data_found,
                );
              }
              return _categoriesGrid(state.categories, _textStyle);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _categoriesGrid(
    List<ProductCategoryModel> categories,
    TextTheme _textStyle,
  ) {
    double maxGridItemWidth = AppConstants.gridCardPrefiredWidth;

    // screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // caluculate proper number of items in one row
    int itemsPerRow = (screenWidth / maxGridItemWidth).floor();

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.s20,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsPerRow,
        childAspectRatio: 1,
        crossAxisSpacing: AppSizes.s10,
        mainAxisSpacing: AppSizes.s10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) => _categoryCard(
        categories[index],
        categories,
        _textStyle,
      ),
    );
  }

  void _cardTapCallBack(
    ProductCategoryModel category,
    List<ProductCategoryModel> categories,
  ) {
    final String path =
        '${AppRoutes.productManagement}/${AppRoutes.category}/${AppRoutes.editCategory}';
    GoRouter.of(context).push(
      path,
      extra: UpdateCategoryExtra(
        categories: categories,
        category: category,
      ).getExtra,
    );
  }

  Widget _categoryCard(ProductCategoryModel category,
      List<ProductCategoryModel> categories, TextTheme _textStyle) {
    return Card(
      child: InkWell(
        onTap: () {
          return _cardTapCallBack(category, categories);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  category.name,
                  style: _textStyle.displayMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
