import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/ExpensesRecordsBloc/expenses_records_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesRecords.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class AddExpensesRecordPage extends StatefulWidget {
  final ExpensesModel expesnes;
  const AddExpensesRecordPage({super.key, required this.expesnes});

  @override
  State<AddExpensesRecordPage> createState() => _AddExpensesRecordPageState();
}

class _AddExpensesRecordPageState extends State<AddExpensesRecordPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _priceController;
  late final TextEditingController _noteController;

  _onSaveB() {
    if (!_formKey.currentState!.validate()) {
      
      return;
    }

    final newRecord = ExpensesRecordsModel(
      amount: double.parse(_priceController.text),
      date: DateTime.now(),
      id: -1,
      note: _noteController.text,
    );

    context.read<ExpensesRecordsBloc>().add(AddRecord(
          expesnes: widget.expesnes,
          context: context,
          records: newRecord,
        ));
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>(); 
    _priceController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose(); 
    _noteController.dispose(); 
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gap(height: AppPaddings.p30),
                Text(
                  context.translate.incur_expense,
                  style: textStyle.titleMedium,
                ),
                Text(
                  '( ${widget.expesnes.name} )',
                  style: textStyle.displayMedium,
                ),
                gap(height: AppSizes.s30),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    AppInputFormatter.price,
                  ],
                  validator: (value){
                    if(value == null){
                      return context.translate.enter_expense_cost;
                    }
                    if(double.tryParse(value) == null){
                      return context.translate.enter_expense_cost;
                    }

                    return null ;
                  },
                  decoration: InputDecoration(
                    hintText: context.translate.cost,
                  ),
                ),
                gap(height: AppSizes.s10),
                TextField(
                  controller: _noteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: context.translate.note,
                  ),
                ),
                gap(height: AppSizes.s100),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: _onSaveB,
                      child: Text(
                        context.translate.save,
                      ),
                    )),
                  ],
                ), 
                //trailing gap 
            
                gap(height: AppSizes.s150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
