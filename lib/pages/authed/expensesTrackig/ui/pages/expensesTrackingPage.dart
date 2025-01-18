import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/expensesBloc/expenses_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/components/expensesCard.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ExpensesTracking extends StatefulWidget {
  const ExpensesTracking({super.key});

  @override
  State<ExpensesTracking> createState() => _ExpensesTrackingState();
}

class _ExpensesTrackingState extends State<ExpensesTracking> {
  
  // add floating button
  Widget? _addButton() {
    return BlocBuilder<ExpensesBloc, ExpensesBlocState>(
      builder: (context, state) {

        if(state is! GotExpenses){
          return const SizedBox.shrink(); 
        }

        return FloatingActionButton(
          onPressed: () async {
            // Navigate to add expense screen
            GoRouter.of(context).push(
                "${AppRoutes.expensesTracking}/${AppRoutes.addExpensesType}");
          },
          child: Icon(
            Icons.add,
            size: AppSizes.s30,
            color: AppColors.onPrimary,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ExpensesBloc>().add(LoadExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addButton(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10,
        ),
        child: Column(
          children: [
            // top gap
            gap(height: AppSizes.s30),

            _resultSection(),
          ],
        ),
      ),
    );
  }

  Widget _resultSection() {
    return BlocBuilder<ExpensesBloc, ExpensesBlocState>(
      builder: (context, state) {
        if (state is LoadingExpenses) {
          return AppLoadingCards.grid(4); 
        }

        if (state is FailedToLoadExpenses) {
          return Text(
            context.translate.something_went_wrong,
          );
        }

        List<ExpensesModel> _expenses = [];
        if (state is GotExpenses) {
          _expenses.addAll(state.expenses);
        }

        return _result(_expenses);
      },
    );
  }

  Widget _result(List<ExpensesModel> expenses) {
    double maxGridItemWidth = AppConstants.gridCardPrefiredWidth;

    // screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // caluculate proper number of items in one row
    int itemsPerRow = (screenWidth / maxGridItemWidth).floor();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.s20,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsPerRow,
        childAspectRatio: 1,
        crossAxisSpacing: AppSizes.s10,
        mainAxisSpacing: AppSizes.s10,
      ),
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpensesCard(
        model: expenses[index],
      ),
    );
  }
}
