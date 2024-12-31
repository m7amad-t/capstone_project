import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_owner/utils/auth/authService.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(Ideal()) {
    // on logout event
    on<Logout>((event, emit) async {
      // emit lading state
      emit(Loading());

      // remove user from secure storage
      await locator<AuthService>().deleteCredentials(locator<User>());

      // aslo unregister user from locator
      if (locator.isRegistered<User>()) {
        locator.unregister<User>();
      }
      emit(LoggedOut());
      print('user is logged out');
    });

    // on auth user event
    on<AuthUser>((event, emit) async {
      // emit lading state
      emit(Loading());
      // 
      // await Future.delayed(Duration(seconds: 1)) ; 

      //
      final User? user = await locator<AuthService>().getCredentials();

      if (user == null) {
        emit(FailedToAuth());
      } else {
        // check if user isn't injected to locator
        if (!locator.isRegistered<User>()) {
          locator.registerSingleton<User>(user);
        } else {
          // if there is already user injected , remove it
          locator.unregister<User>();

          // inject new user to locator
          locator.registerSingleton<User>(user);
        }

        emit(UserAuthed(user: locator<User>()));
        return ; 
      }
      // check if user logged in
    });
  }
}
