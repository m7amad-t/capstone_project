import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class ProductCategoryFilter extends StatelessWidget {
  final GotProducts state;
  const ProductCategoryFilter({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.s45,
      width: locator<DynamicSizes>().p80,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(right: AppSizes.s10),
              child: InkWell(
                onTap: () {
                  context
                      .read<ProductBloc>()
                      .add(SelectCategory(category: state.categories[index]));
                },
                child: Chip(
                  label: Text(state.categories[index].name),
                  backgroundColor: Colors.blue,
                ),
              ));
        },
      ),
    );
  }
}
