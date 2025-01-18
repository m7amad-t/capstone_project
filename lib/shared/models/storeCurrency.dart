// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class StoreCurrency {
  final String sign;
  final String name;

  StoreCurrency({required this.sign, required this.name});

  Map<String, dynamic> get toMap {
    return {
      "currency": {
        "sign": sign,
        "name": name,
      }
    };
  }

  static STORE_CURRENCY storeCurrencyFromString(String text) {
    return fromString(text);
  }

  factory StoreCurrency.fromJson(Map<String, dynamic> map) {
    return StoreCurrency(
      sign: map["sign"] as String,
      name: map["name"] as String,
    );
  }
}

List<STORE_CURRENCY> STORE_CURRENCY_LIST = [
  STORE_CURRENCY.DINAR,
  STORE_CURRENCY.DOLLAR,
  STORE_CURRENCY.EURO,
  STORE_CURRENCY.DIRHAM,
  STORE_CURRENCY.LIRA,
];

enum STORE_CURRENCY {
  DOLLAR,
  DINAR,
  EURO,
  LIRA,
  DIRHAM,
}

STORE_CURRENCY fromString(String text) {
  if (text == "\$") {
    return STORE_CURRENCY.DOLLAR;
  } else if (text == "IQD") {
    return STORE_CURRENCY.DINAR;
  } else if (text == "DH") {
    return STORE_CURRENCY.DIRHAM;
  } else if (text == "€") {
    return STORE_CURRENCY.EURO;
  } else if (text == "₺") {
    return STORE_CURRENCY.LIRA;
  } else {
    return STORE_CURRENCY.DOLLAR;
  }
}

extension StoreCurrencies on STORE_CURRENCY {
  String get name {
    if (this == STORE_CURRENCY.DOLLAR) {
      return locator<BuildContext>().translate.dollar;
    } else if (this == STORE_CURRENCY.DINAR) {
      return locator<BuildContext>().translate.dinar;
    } else if (this == STORE_CURRENCY.DIRHAM) {
      return locator<BuildContext>().translate.dirham;
    } else if (this == STORE_CURRENCY.EURO) {
      return locator<BuildContext>().translate.euro;
    } else if (this == STORE_CURRENCY.LIRA) {
      return locator<BuildContext>().translate.lira;
    } else {
      return locator<BuildContext>().translate.dollar;
    }
  }

  String name1(BuildContext context) {
    if (this == STORE_CURRENCY.DOLLAR) {
      return context.translate.dollar;
    } else if (this == STORE_CURRENCY.DINAR) {
      return context.translate.dinar;
    } else if (this == STORE_CURRENCY.DIRHAM) {
      return context.translate.dirham;
    } else if (this == STORE_CURRENCY.EURO) {
      return context.translate.euro;
    } else if (this == STORE_CURRENCY.LIRA) {
      return context.translate.lira;
    } else {
      return context.translate.dollar;
    }
  }

  String get sign {
    if (this == STORE_CURRENCY.DOLLAR) {
      return "\$";
    } else if (this == STORE_CURRENCY.DINAR) {
      return "IQD";
    } else if (this == STORE_CURRENCY.DIRHAM) {
      return "DH";
    } else if (this == STORE_CURRENCY.EURO) {
      return "€";
    } else if (this == STORE_CURRENCY.LIRA) {
      return "₺";
    } else {
      return "\$";
    }
  }
}
