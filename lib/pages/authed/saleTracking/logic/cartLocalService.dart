// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/cartModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class CartLocalService {

  static String _cartKey = 'cart';
  
  get cartKey => _cartKey;

  static Future<void> saveCart(List<CartModel> cartData) async {
    
    late final SharedPreferences pref ;  
    // check if its in the locator 
    if(locator.isRegistered<SharedPreferences>()){
      pref = locator<SharedPreferences>();
    }else {
      pref = await SharedPreferences.getInstance();
      locator.registerSingleton<SharedPreferences>(pref);
    }

    // convert cart data to json
    final String jsonData = jsonEncode(CartModel.listToMap(cartData));

    // save to shared preferences
    await pref.setString(_cartKey, jsonData);

    
  }
  
  static Future<List<CartModel>> loadFromLocal() async {
    late final SharedPreferences pref ;  

    // check if its in the locator 
    if(locator.isRegistered<SharedPreferences>()){
      pref = locator<SharedPreferences>();
    }else {
      pref = await SharedPreferences.getInstance();
      locator.registerSingleton<SharedPreferences>(pref);
    }

    final String? json = pref.getString(_cartKey) ; 
    
    if(json == null){
      return [];
    }

    // decode json
    final Map<String, dynamic> jsonMap  = jsonDecode(json); 

    // convert to list of cart model
    return CartModel.listFromMap(jsonMap);


  }
}
