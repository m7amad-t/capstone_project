import 'package:shop_owner/shared/models/storeCurrency.dart';
import 'package:shop_owner/utils/auth/userModel.dart';

class AuthedUser {
  final String name;
  final int id;
  final STORE_CURRENCY currency;
  final List<User> users;
  final User user; 

  AuthedUser({
    required this.user, 
    required this.name,
    required this.id,
    required this.currency,
    required this.users,
  });




  factory AuthedUser.fromJson(Map<String, dynamic> data , User user) {
    
    return AuthedUser(
      currency: StoreCurrency.storeCurrencyFromString(data['currency']),
      id: data['id'],
      user : user,
      name: data['name'],
      users: User.listFromJson(data),
    );
  }

  AuthedUser update(Map<String, dynamic> data) {
    return AuthedUser(
      currency: data['currency'] ?? currency,
      id: data['id'] ?? id,
      user: data['user'] ?? user,
      name: data['name'] ?? name,
      users: data['users'] ?? users,
    );
  }

  @override
  String toString() {
    
    return "$id    |    $name    |    $currency    |    $user    |    $users"; 
  }
}
