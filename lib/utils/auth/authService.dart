
// ignore_for_file: file_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_owner/utils/auth/userModel.dart';

class AuthService {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  late final FlutterSecureStorage _secureStorage;

  
  AuthService() {
    try{
    _secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    }catch(e){
      print(e);
      rethrow; 
    }
  }

  // save user credentials in the secure storage
  Future<void> signUser(User user) async {
    try {
      // save user data ;
      await _secureStorage.write(key: 'user', value: user.toJson());
    } catch (e) {
      print(e);
    }
  }

  // get user credentials in the secure storage
  Future<User?> getCredentials() async {
    try {
      // save user data ;
      final data = await _secureStorage.read(key: 'user');
      // check if data is null
      if (data == null || data.isEmpty) {
        return null;
      }

      return User.fromJson(data); 
    } catch (e) {

      return null;
    }
  }

  // delete user credentials in the secure storage
  Future<void> deleteCredentials(User user) async {
    try{
    await _secureStorage.delete(key: 'user');
    }catch (e) {
      print(e); 
    }
  }
}
