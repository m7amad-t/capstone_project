import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/expensesBloc/expenses_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class AddNewExpensesTypePage extends StatefulWidget {
  const AddNewExpensesTypePage({super.key});

  @override
  State<AddNewExpensesTypePage> createState() => _AddNewExpensesTypePageState();
}

class _AddNewExpensesTypePageState extends State<AddNewExpensesTypePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final List<ExpensesModel>? _expensesType;
  late final TextEditingController _nameController;

  void getExpenses() {
    final state = context.read<ExpensesBloc>().state;

    if (state is GotExpenses) {
      _expensesType = state.expenses;
    } else {  
      _expensesType = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    getExpenses();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSaveB() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // create model for the new expenses model
    final ExpensesModel newExpensesType = ExpensesModel(
      name: _nameController.text,
      id: -1,
    );

    context.read<ExpensesBloc>().add(AddNewExpenses(
          newExpenses: newExpensesType,
          context: context,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10,
        ),
        child: Column(
          children: [
            // top gap
            gap(height: AppSizes.s30),

            // title
            Text(
              context.translate.add_new_expense,
              style: textStyle.displayLarge,
            ),

            gap(height: AppSizes.s50),

            _inputForm(),
          ],
        ),
      ),
    );
  }

  Widget _inputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // name field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: context.translate.expense_name,
            ),
            validator: (value) {
              if (value == null) {
                return context.translate.enter_expense_name;
              }
              if (value.isEmpty) {
                return context.translate.enter_expense_name;
              }
              if (_expensesType == null) {
                return null;
              }
              for (final exp in _expensesType) {
                if (exp.name == value) {
                  return context.translate.expense_already_exist;
                }
              }

              return null;
            },
          ),

          gap(height: AppSizes.s30),

          // save button .
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _onSaveB,
                  child: Text(
                    context.translate.save,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
