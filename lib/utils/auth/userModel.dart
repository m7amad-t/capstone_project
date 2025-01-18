// ignore_for_file: file_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final bool admin;
  final String username; 
  const User({
    required this.uid,
    required this.name,
    required this.username,
    required this.admin,
  });

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'admin': admin , 'username' : username} ;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(uid: map['uid'], name: map['name'], admin: map['admin'] , username: map['username'] );
  }

  static List<User> listFromJson(Map<String, dynamic> data) {
    List<User> users = [];

    for (final user in data['users']) {
      users.add(User.fromMap(user));
    }
    return users;
  }

  // to json
  String toJson() => json.encode(toMap());

  // form json
  static User fromJson(String jsonString) =>
      User.fromMap(json.decode(jsonString));

  User update(Map<String, dynamic> data) {
    return User(
      uid: data['uid'] ?? uid,
      username: data['username'] ?? uid,
      name: data['name'] ?? name,
      admin: data['admin'] ?? admin,
    );
  }

  @override
  String toString() {
    return "User Model : {\n\tuid : $uid,\n\tname : $name\n\tadmin : $admin\n}";
  }

  @override
  List<Object?> get props => [uid, name, admin ,username];
}
