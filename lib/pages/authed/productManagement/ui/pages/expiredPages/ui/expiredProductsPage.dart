import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/expiredProductsBloc/expired_products_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/models/expiredProductModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/ui/components/expiredProductCard.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class ExpiredProductsPage extends StatefulWidget {
  const ExpiredProductsPage({super.key});

  @override
  State<ExpiredProductsPage> createState() => _ExpiredProductsPageState();
}

class _ExpiredProductsPageState extends State<ExpiredProductsPage> {

  // late final ValueNotifier<NEAR_EXPIRED_OPTIONS?> _expireIn = 

  @override
  void initState() {
    super.initState();
    context.read<ExpiredProductsBloc>().add(ReloadExpiredProducts()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          print(''); 
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
          child: Column(
            children: [
              _resultSection(),
          
              gap(height: AppSizes.s150),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultSection() {
    return BlocBuilder<ExpiredProductsBloc, ExpiredProductsBlocState>(
      builder: (context, state) {
        if (state is LoadingExpiredProducts) {
          return AppLoadingCards(height: AppSizes.s150);
        }

        if (state is FailedToLoadExpiredProducts) {
          return Text('Failed to load');
        }

        List<ExpiredProductModel> records = [];

        if (state is GotExpiredProducts) {
          records.addAll(state.records);
        }

        if (records.isEmpty) {
          return Text('No expired products found');
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: records.length,
          itemBuilder: (context, index) {
            return ExpiredProductCard(record: records[index]).marginOnly(
              top: index == 0 ? AppSizes.s35 : 0 ,
              bottom: AppPaddings.p10);
          },
        );
      },
    );
  }
}
