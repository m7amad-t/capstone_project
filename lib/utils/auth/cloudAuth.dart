import 'package:shop_owner/pages/notAuthed/login/logic/model/loginModel.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/auth/userModel.dart';

  // predefined users
  final List<Map<String, dynamic>> _stores = [
    //  book store
    {
      'name': "Book Store",
      "id": 1,
      "currency": "\$",
      "users": [
        // user1
        {
          "username": "user1",
          "name": "Mohammed",
          'password': "1234",
          "admin": true,
          "uid": "aoF8-xnu6-j2dk-ast7-sfdh"
        },
        // user2
        {
          "username": "user2",
          "name": "Kawan",
          'password': "1234",
          "admin": false,
          "uid": "lkas-Lc9a-jsa7-cnbu-asD8"
        },
        // user3
        {
          "username": "user3",
          "name": "Abdulla",
          'password': "1234",
          "admin": true,
          "uid": "lFf9-9sne-nus5-asd6-Ddbu"
        },
      ],
    },

    //  Electronic store
    {
      'name': "KURD TECH",
      "id": 2,
      "currency": "IQD",
      "users": [
        // user1
        {
          "username": "user4",
          "name": "Zhyar",
          'password': "1234",
          "admin": true,
          "uid": "aoF8-xfu6-A22k-a9t7-Sfdf"
        },
        // user2
        {
          "username": "user5",
          "name": "Aland",
          'password': "1234",
          "admin": false,
          "uid": "lkas-Lc9a-jsa7-cnbu-asD8"
        },
      ],
    },

    //  Market store
    {
      'name': "Rezhwan Market",
      "id": 3,
      "currency": "\$",
      "users": [
        // user1
        {
          "username": "user6",
          "name": "Bazhdar",
          'password': "1234",
          "admin": true,
          "uid": "2oFa-MZu6-AKO1-a1tx-P1df"
        },
        // user2
        {
          "username": "user7",
          "name": "Karwan",
          'password': "1234",
          "admin": false,
          "uid": "lA2s-LI1a-nSaQ-1Ps0-qa0T"
        },
      ],
    },
  ];


class CloudAuth {
  //* this class is use only to memec real world example of how to auth user


  // Authenticate user by username and password
  Future<AuthedUser?> auth(LoginModel credentials) async {
    // simulate authentication
    await Future.delayed(const Duration(seconds: 1));
    // check if user is in list , and credentials are correct

    for (final store in _stores) {
      for (final user in store['users']) {
        if (user['username'] == credentials.username &&
            user['password'] == credentials.password) {
          // creat usermodel
          final User userModel = User.fromMap({
            'uid': user['uid'],
            'name': user['name'],
            'admin': user['admin'],
            'username': user['username'],
          });

          // create store model
          final AuthedUser authed = AuthedUser.fromJson(store, userModel);

          return authed;
        }
      }
    }

    return null;
  }

  // Authenticate user by username and password
  Future<AuthedUser?> authLocal(User localUser) async {
    // simulate authentication
    // await Future.delayed(const Duration(seconds: 1));
    // check if user is in list , and credentials are correct
    for (final store in _stores) {
      for (final user in store['users']) {
        if (user['uid'] == localUser.uid) {
          // creat usermodel
          final User userModel = User.fromMap({
            'uid': user['uid'],
            'name': user['name'],
            'admin': user['admin'],
            'username': user['username'],
          });

          // create authed user model
          final AuthedUser authed = AuthedUser.fromJson(store, userModel);

          return authed;
          // if user is valid , return true
          // return User.fromMap({
          //   'uid': user['uid'],
          //   'name': user['name'],
          //   'admin': user['admin'],
          // });
        }
      }
    }

    return null;
  }

  void addNewUser(AuthedUser authedUser, User user, String password) {
    print('adding new user');
    for (final store in _stores) {

      if (store['id'] == authedUser.id) {
        final newData = {
          "username": user.username,
          "name": user.name,
          'password': password,
          "admin": user.admin,
          "uid": user.uid, 
        };

        store['users'] = [...store['users'] , newData]; 
      }
    }
    
  }
}
