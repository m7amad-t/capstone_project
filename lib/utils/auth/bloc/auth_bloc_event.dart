part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}


class AuthUser extends AuthBlocEvent {
  
}


class Logout extends AuthBlocEvent {
  
}
