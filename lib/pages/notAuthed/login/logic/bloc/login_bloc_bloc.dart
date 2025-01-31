// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/notAuthed/login/logic/model/loginModel.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/utils/auth/authService.dart';
import 'package:shop_owner/utils/auth/bloc/auth_bloc_bloc.dart';
import 'package:shop_owner/utils/auth/cloudAuth.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(Ideal()) {

    Future<void> _onLogin (Login event , emit)async{

      // fake the login flow :::
      locator<AppDialogs>().showSigningIn();
      
      
      // simulate a delay for the login process
      final CloudAuth authService = CloudAuth();
     

      final AuthedUser? user = await authService.auth(event.model);



      if (user == null) {

        // emit error
        emit(FailedToLogin());

        locator<AppDialogs>().disposeAnyActiveDialogs();
        // send snakbar
        showSnackBar(
          message: FailedSnackBar(
            title: event.context.translate.wrong_credintials,
            message: "",
          ),
        );
        return;
      }

      // sucessfully logged in

      // inject user model to locator
      await locator<AuthService>().signUser(user.user);

      // pop loading dialog
      locator<AppDialogs>().disposeAnyActiveDialogs();

      // send snackabr
      showSnackBar(
        message: SuccessSnackBar(
          title: event.context.translate.successfully_signed_in,
          message: "",
        ),
      );
      // call auth bloc to auth curent user , redirect user to home page
      event.context.read<AuthBloc>().add(AuthUser(context: event.context));
    }
    
  
    on<Login>(_onLogin);
  }
}
