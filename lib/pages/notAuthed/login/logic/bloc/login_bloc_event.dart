part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocEvent extends Equatable {}

class Login extends LoginBlocEvent {
  final BuildContext context;
  final LoginModel model; 
  Login({required this.context , required this.model}); 

  @override
  List<Object?> get props => [context , model];
}
