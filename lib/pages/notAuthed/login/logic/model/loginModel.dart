// ignore_for_file: file_names

class LoginModel {
  final String username;
  final String password;
  const LoginModel({required this.username, required this.password});

  @override
  String toString() {
    return "LoginModel : username: $username\tpassword:  $password"; 
  }
}
