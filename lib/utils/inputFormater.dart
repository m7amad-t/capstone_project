import 'package:flutter/services.dart';

class AppInputFormatter{

  // format inpput for numbers only 
  static TextInputFormatter numbersOnly =  TextInputFormatter.withFunction(
    (oldValue, newValue) {
      // remove any characters that are not numbers 
      String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      // if newText is not equal to oldValue, return newText as the new value
      return TextEditingValue(
        text: newText,
      ); 
    },
  ); 
  // format inpput for price (numbers and . ) 
  static TextInputFormatter price =  TextInputFormatter.withFunction(
    (oldValue, newValue) {
      // remove any characters that are not numbers 
      String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
      // if newText is not equal to oldValue, return newText as the new value
      return TextEditingValue(
        text: newText,
      ); 
    },
  ); 

}