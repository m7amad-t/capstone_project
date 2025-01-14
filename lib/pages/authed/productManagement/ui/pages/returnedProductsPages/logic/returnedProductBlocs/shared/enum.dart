// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names


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

// extension ReturnReasonExtension on RETURN_PRODUCT_REASON {
//   String name(BuildContext context) {
//     switch (this) {
//       case RETURN_PRODUCT_REASON.CUSTOM_REASON:
//         return 'costumer reason';
//       case RETURN_PRODUCT_REASON.DAMAGED:
//         return 'damaged';
//       case RETURN_PRODUCT_REASON.DEFECTIVE:
//         return 'defective';
//       case RETURN_PRODUCT_REASON.EXPIRED:
//         return 'Expired';
//       case RETURN_PRODUCT_REASON.MISSIN_PARTS:
//         return 'missing parts';
//       case RETURN_PRODUCT_REASON.NOT_WHAT_EXPECTED:
//         return 'not what expected';
//       default:
//         return 'unknown reason';
//     }
//   }
// }