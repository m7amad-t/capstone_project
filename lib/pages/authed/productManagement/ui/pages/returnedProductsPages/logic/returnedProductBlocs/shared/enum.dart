// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names


import 'package:flutter/cupertino.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

enum RETURN_PRODUCT_REASON {
  EXPIRED,
  DAMAGED,
  CUSTOM_REASON,
  DEFECTIVE,
  MISSIN_PARTS,
  NOT_WHAT_EXPECTED,
  UNKNOWN,
}

List<RETURN_PRODUCT_REASON> RETURN_REASON_LIST = [
  RETURN_PRODUCT_REASON.EXPIRED,
  RETURN_PRODUCT_REASON.DAMAGED,
  RETURN_PRODUCT_REASON.CUSTOM_REASON,
  RETURN_PRODUCT_REASON.DEFECTIVE,
  RETURN_PRODUCT_REASON.MISSIN_PARTS,
  RETURN_PRODUCT_REASON.NOT_WHAT_EXPECTED,
]; 

RETURN_PRODUCT_REASON getReasonEnumFromStrign(String text) {
  switch (text) {
    case 'expired':
      return RETURN_PRODUCT_REASON.EXPIRED;
    case 'damaged':
      return RETURN_PRODUCT_REASON.DAMAGED;
    case 'custom_reason':
      return RETURN_PRODUCT_REASON.CUSTOM_REASON;
    case 'defective':
      return RETURN_PRODUCT_REASON.DEFECTIVE;
    case 'missing_parts':
      return RETURN_PRODUCT_REASON.MISSIN_PARTS;
    case 'not_what_expected':
      return RETURN_PRODUCT_REASON.NOT_WHAT_EXPECTED;
    default:
      return RETURN_PRODUCT_REASON.UNKNOWN;
  }
}

extension ReturnReasonExtension on RETURN_PRODUCT_REASON {
  String name(BuildContext context) {
    switch (this) {
      case RETURN_PRODUCT_REASON.CUSTOM_REASON:
        return context.translate.costumer_reason;
      case RETURN_PRODUCT_REASON.DAMAGED:
        return context.translate.damaged;
      case RETURN_PRODUCT_REASON.DEFECTIVE:
        return context.translate.deffective;
      case RETURN_PRODUCT_REASON.EXPIRED:
        return context.translate.expired;
      case RETURN_PRODUCT_REASON.MISSIN_PARTS:
        return context.translate.missing_parts;
      case RETURN_PRODUCT_REASON.NOT_WHAT_EXPECTED:
        return context.translate.not_what_expected;
      default:
        return "UNKNOWN";
    }
  }
}