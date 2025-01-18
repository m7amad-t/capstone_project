part of 'system_users_bloc_bloc.dart';

sealed class SystemUsersBlocEvent extends Equatable {
  const SystemUsersBlocEvent();

  @override
  List<Object> get props => [];
}




final class AddNewUser extends SystemUsersBlocEvent {

  final User user ;
  final String password ; 
  const AddNewUser({required this.user , required this.password}); 

  @override
  List<Object> get props => [user , password];

}

final class DeleteUser extends SystemUsersBlocEvent {


  final User user ;

  const DeleteUser({required this.user});


  @override
  List<Object> get props => [user];

}

final class UpdateUser extends SystemUsersBlocEvent {
  
  final User user ;
  final Map<String, dynamic> updated;

  const UpdateUser({required this.user, required this.updated}); 

  @override
  List<Object> get props => [user ,updated];

}