// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/utils/auth/authService.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(InitAuthState()) {
    // on logout event
    on<Logout>((event, emit) async {

      // emit lading state

      // remove user from secure storage
      await locator<AuthService>().deleteCredentials(locator<AuthedUser>().user);

      emit(LoggedOut());
      // navigate user back to login screen
      GoRouter.of(event.context).go(AppRoutes.login);

      // aslo unregister user from locator
      if (locator.isRegistered<AuthedUser>()) {
        locator.unregister<AuthedUser>();
      }

    });

    // on auth user event
    on<AuthUser>((event, emit) async {


      // emit lading state
      emit(Loading());
      // 
      // await Future.delayed(Duration(seconds: 1)) ; 

      final AuthedUser? user = await locator<AuthService>().getCredentials();

      if (user == null) {

        emit(FailedToAuth());

        // navigate user back to login screen 
        GoRouter.of(event.context).go(AppRoutes.login); 
    
        // if(GoRouter.of(event.context).)
      } else {
        

        // check if user isn't injected to locator
        if (!locator.isRegistered<AuthedUser>()) {

          locator.registerSingleton<AuthedUser>(user);
        } else {

          // if there is already user injected , remove it
          locator.unregister<AuthedUser>();
          // inject new user to locator
          locator.registerSingleton<AuthedUser>(user);

        }

        emit(UserAuthed(user: locator<AuthedUser>()));

        // navigate user to home page
        GoRouter.of(event.context).go(AppRoutes.home); 

        return ; 
      }
      // check if user logged in
    });
  }
}
