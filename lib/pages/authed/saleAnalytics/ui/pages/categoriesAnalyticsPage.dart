// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/analyticsOptionsEnum.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoriesComponents/damagedWidget.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoriesComponents/returnedWidget.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoriesComponents/revenueWidgets.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoriesComponents/saleWidgtes.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CategoriesAnalyticsPage extends StatefulWidget {
  const CategoriesAnalyticsPage({
    super.key,
  });

  @override
  State<CategoriesAnalyticsPage> createState() => _CategoriesAnalyticsPageState();
}

class _CategoriesAnalyticsPageState extends State<CategoriesAnalyticsPage> {
  ANALYTICS_OPTIONS _selectedOption = ANALYTICS_OPTIONS.REVENUE;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    late final Widget mainSection;
    if (_selectedOption == ANALYTICS_OPTIONS.REVENUE) {
      mainSection = const CategoryRevenueSection();
    } else if (_selectedOption == ANALYTICS_OPTIONS.SALE) {
      mainSection = const CategorySaleSection();
    }else if (_selectedOption == ANALYTICS_OPTIONS.RETURNED){
      mainSection = const CategoryReturnedSection();
    }else {
      mainSection = const CategoryDamagedSection();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          // top gap
          gap(height: AppPaddings.p30),
          // drop down menu

          _options(textStyle).paddingSymmetric(horizontal: AppPaddings.p10),

          mainSection,

          // trailing gap....
          gap(height: AppSizes.s150),
        ],
      ),
    );
  }

  Widget _options(TextTheme textStyle) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: AppSizes.s6,
            ),
            padding:const  EdgeInsets.symmetric(horizontal: AppSizes.s8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(AppSizes.s8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ANALYTICS_OPTIONS>(
                value: _selectedOption,
                items: [
                  DropdownMenuItem(
                    value: ANALYTICS_OPTIONS.REVENUE,
                    child: Text(
                      context.translate.revenue,
                      style: textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ANALYTICS_OPTIONS.SALE,
                    child: Text(
                      context.translate.sale,
                      style: textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ANALYTICS_OPTIONS.RETURNED,
                    child: Text(
                      context.translate.returned,
                      style: textStyle.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ANALYTICS_OPTIONS.DAMAGED,
                    child: Text(
                      context.translate.damaged,
                      style: textStyle.bodyMedium,
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
