// ignore_for_file: camel_case_types, constant_identifier_names, camel_case_extensions

import 'package:flutter/material.dart';

enum PURCHASE_UNITE_TYPE {
  PACKAGE,
  ITEM,
}


enum COST_UNITE_TYPE {
  
  TOTAL,
  PACKAGE,
  ITEM,
}


extension cost_unit_types_name on COST_UNITE_TYPE {
  String name(BuildContext context) {
    switch (this) {
      case COST_UNITE_TYPE.TOTAL:
        return 'Total';
      case COST_UNITE_TYPE.PACKAGE:
        return 'Package';
      case COST_UNITE_TYPE.ITEM:
        return 'Item';
    }
  }
}


extension pruchase_unit_type_name on PURCHASE_UNITE_TYPE {
  String name(BuildContext context) {
    switch (this) {
      case PURCHASE_UNITE_TYPE.PACKAGE:
        return 'Package';
      case PURCHASE_UNITE_TYPE.ITEM:
        return 'Item';
    }
  }
}



