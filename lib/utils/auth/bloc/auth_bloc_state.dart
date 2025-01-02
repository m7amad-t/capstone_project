part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState extends Equatable {
  const AuthBlocState();
  
  @override
  List<Object> get props => [];
}

final class InitAuthState extends AuthBlocState {}


final class UserAuthed extends AuthBlocState{
  final User user ; 
  const UserAuthed({required this.user});
  @override
  List<Object> get props => [user];
}
final class Loading extends AuthBlocState{

}

final class FailedToAuth extends AuthBlocState{

}

final class LoggedOut extends AuthBlocState{

}