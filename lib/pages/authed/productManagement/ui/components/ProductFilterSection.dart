import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductFilterSection extends StatelessWidget {
  const ProductFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s70,
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: AppSizes.s5,
          top: AppSizes.s5,
        ),
        child: BlocBuilder<ProductBloc, ProductBlocState>(
          builder: (context, state) {
            if (state is LoadingProducts || state is FailedToLoad) {
              return Container();
            }

            List<ProductCategoryModel> categories = [];
            ProductCategoryModel? selectedCategory;
            if (state is GotProducts) {
              categories = List.from(state.categories);
              selectedCategory = state.selectedCategory;
            }

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // cuz we wraped the product list we add trailing gap
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index < categories.length) {
                  final ProductCategoryModel category = categories[index];
                  // check if category is the one how selected

                  final bool isMeHowSelected = selectedCategory == null
                      ? false
                      : selectedCategory.name == category.name;

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
                            horizontal: AppPaddings.p10,
                            vertical: AppPaddings.p8,
                          ),
                        ),
                      ),
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(SelectCategory(category: categories[index]));
                      },
                      child: Text(
                        categories[index].name,
                        style: textStyle.bodySmall!.copyWith(
                          color: isMeHowSelected ? AppColors.onPrimary : null,
                        ),
                      ),
                    ),
                  );
                }
                // all button
                return Container(
                  margin: EdgeInsets.only(
                    
                    left: !context.fromLTR ? AppSizes.s10 : 0 ,
                    right: !context.fromLTR ? AppSizes.s10 : 0 ,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        selectedCategory == null
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
                      style: textStyle.bodySmall!.copyWith(
                        color: selectedCategory == null
                            ? AppColors.onPrimary
                            : null,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
