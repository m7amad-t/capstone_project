part of 'system_users_bloc_bloc.dart';

sealed class SystemUsersBlocState extends Equatable {
  const SystemUsersBlocState();
  
  @override
  List<Object> get props => [];
}

final class SystemUsersBlocInitial extends SystemUsersBlocState {}


final class AuthUpdated extends SystemUsersBlocState{
  final AuthedUser   authData;

  const AuthUpdated(this.authData);

  @override
  List<Object> get props => [authData];
}

