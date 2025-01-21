part of 'system_users_bloc_bloc.dart';

sealed class SystemUsersBlocEvent extends Equatable {

  final BuildContext context ; 
  const SystemUsersBlocEvent({required this.context});

  @override
  List<Object> get props => [];
}




final class AddNewUser extends SystemUsersBlocEvent {

  final User user ;
  final String password ; 
  const AddNewUser({required this.user , required this.password, required super.context}); 

  @override
  List<Object> get props => [user , password];

}

final class DeleteUser extends SystemUsersBlocEvent {


  final User user ;

  const DeleteUser({required this.user, required super.context});


  @override
  List<Object> get props => [user];

}

final class UpdateUser extends SystemUsersBlocEvent {
  
  final User user ;
  final bool imageUpdated ; 
  final Map<String, String?> updated;

  const UpdateUser({required this.user,required this.imageUpdated ,  required this.updated, required super.context}); 

  @override
  List<Object> get props => [user ,updated];

}