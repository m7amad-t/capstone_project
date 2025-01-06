// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/utils/auth/authService.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(InitAuthState()) {
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
      // navigate user back to login screen
      GoRouter.of(event.context).go(AppRoutes.login);
    });

    // on auth user event
    on<AuthUser>((event, emit) async {

      print("auth user bloc"); 

      // emit lading state
      emit(Loading());
      // 
      // await Future.delayed(Duration(seconds: 1)) ; 

      //
      final User? user = await locator<AuthService>().getCredentials();
      print("checking use is done "); 



      if (user == null) {
      print("user was null"); 

        emit(FailedToAuth());

        // navigate user back to login screen 
        GoRouter.of(event.context).go(AppRoutes.login); 
    
        // if(GoRouter.of(event.context).)
      } else {
      print("user was not null"); 
        

        // check if user isn't injected to locator
        if (!locator.isRegistered<User>()) {
        print("injecting the user"); 

          locator.registerSingleton<User>(user);
        } else {
        print("user is already registered"); 

          // if there is already user injected , remove it
          locator.unregister<User>();
  print('un registration'); 
          // inject new user to locator
          locator.registerSingleton<User>(user);

          print('new user is registered');
        }

        emit(UserAuthed(user: locator<User>()));

        print('navigate to home screen'); 
        // navigate user to home page
        GoRouter.of(event.context).go(AppRoutes.home); 

        print('navigate to home page is done....');
        return ; 
      }
      // check if user logged in
    });
  }
}
