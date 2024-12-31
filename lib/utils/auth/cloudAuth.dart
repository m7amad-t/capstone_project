import 'package:shop_owner/pages/login/logic/model/loginModel.dart';
import 'package:shop_owner/utils/auth/userModel.dart';

class CloudAuth {
  //* this class is use only to memec real world example of how to auth user

  // predefined users
  final List<Map<String, dynamic>> _users = [
    // user1
    {
      "username": "user1",
      "name": "Mohammed",
      'password': "1234",
      "uid": "aoF8-xnu6-j2dk-ast7-sfdh"
    },
    // user2
    {
      "username": "user2",
      "name": "Kawan",
      'password': "1234",
      "uid": "lkas-Lc9a-jsa7-cnbu-asD8"
    },
    // user3
    {
      "username": "user3",
      "name": "Abdulla",
      'password': "1234",
      "uid": "lFf9-9sne-nus5-asd6-Ddbu"
    },
    // user4
    {
      "username": "user4",
      "name": "Amir",
      'password': "1234",
      "uid": "lksd-21Kk-ask9-asdh-sHni"
    },
    // user5
    {
      "username": "user5",
      "name": "Ahmad",
      'password': "1234",
      "uid": "msau-8RhY-sfd8-slkk-sdu7"
    },
  ];

  // Authenticate user by username and password
  Future<User?> auth(LoginModel credentials) async {

    // simulate authentication
    await Future.delayed(const Duration(seconds: 1));  
    // check if user is in list , and credentials are correct
    for (final user in _users) {
      if (user['username'] == credentials.username &&
          user['password'] == credentials.password) {
        // if user is valid , return true
        return User.fromMap({
          'uid': user['uid'],
          'name': user['name'],
        });
      }
    }

    return null;
  }
}
