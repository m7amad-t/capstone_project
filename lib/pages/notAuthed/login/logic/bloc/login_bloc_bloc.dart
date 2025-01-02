
// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/notAuthed/login/logic/model/loginModel.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/uiHelper.dart';
import 'package:shop_owner/utils/auth/authService.dart';
import 'package:shop_owner/utils/auth/bloc/auth_bloc_bloc.dart';
import 'package:shop_owner/utils/auth/cloudAuth.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(Ideal()) {

    on<Login>((event, emit) async {
      // fake the login flow :::

      // show a loading dialog
      showLoadingDialog(event.context, event.context.translate.login);

      // simulate a delay for the login process
      final CloudAuth authService = CloudAuth();

      final User? user = await authService.auth(event.model);

      if (user == null) {
        // emit error
        emit(FailedToLogin());

        popCurrent(event.context);
        // send snakbar
        showSnackBar(
          message: FailedSnackBar(
            title: event.context.translate.something_went_wrong,
            message: event.context.translate.something_went_wrong,
          ),
        );
        return;
      }

      // sucessfully logged in

      // inject user model to locator
      await locator<AuthService>().signUser(user);

      // pop loading dialog
      popCurrent(event.context);
      // send snackabr
      showSnackBar(
        message: SuccessSnackBar(
          title: event.context.translate.login_successful,
          message: event.context.translate.login_successful,
        ),
      );
      // call auth bloc to auth curent user , redirect user to home page 
      event.context.read<AuthBloc>().add(AuthUser()); 
    });
  }
}
