part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocState extends Equatable{

}

final class Ideal extends LoginBlocState {
  @override
  List<Object?> get props => []; 
}

final class LoggedIn extends LoginBlocState {
  @override
  List<Object?> get props => [];
}

final class FailedToLogin extends LoginBlocState {
  @override
  List<Object?> get props => []; 
}



