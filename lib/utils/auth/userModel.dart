

// ignore_for_file: file_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;  

  const User({required this.uid , required this.name});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name, 
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(uid: map['uid'] , name: map['name']);
  }

  // to json
  String toJson() => json.encode(toMap());

  // form json
  static User fromJson(String jsonString) =>
      User.fromMap(json.decode(jsonString));


  @override
  String toString() {
    return "User Model : {\n\tuid : $uid,\n\tname : $name\n}"; 
  }

  @override
  List<Object?> get props => [uid , name];
}
