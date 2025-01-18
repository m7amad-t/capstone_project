import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';

class ExpensExtra{
  
  static String expensesField = "expenses"; 

  final ExpensesModel model; 

  ExpensExtra({required this.model});

  Map<String ,dynamic> get extra {
    return {
      expensesField : model, 
    }; 
  }

}
