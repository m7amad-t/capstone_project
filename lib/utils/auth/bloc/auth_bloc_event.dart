part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {
  final BuildContext context; 
  const AuthBlocEvent({required this.context});

  @override
  List<Object> get props => [context];
}


class AuthUser extends AuthBlocEvent {

  const AuthUser({required super.context}); 

}


class Logout extends AuthBlocEvent {
  const Logout({required super.context});
  
}
