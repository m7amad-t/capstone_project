import 'package:flutter/services.dart';

class AppInputFormatter{

  // format inpput for numbers only 
  static TextInputFormatter numbersOnly = new TextInputFormatter.withFunction(
    (oldValue, newValue) {
      // remove any characters that are not numbers 
      String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      // if newText is not equal to oldValue, return newText as the new value
      return TextEditingValue(
        text: newText,
      ); 
    },
  ); 

}