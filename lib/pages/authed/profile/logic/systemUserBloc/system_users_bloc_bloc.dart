import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/auth/cloudAuth.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'system_users_bloc_event.dart';
part 'system_users_bloc_state.dart';

class SystemUsersBloc extends Bloc<SystemUsersBlocEvent, SystemUsersBlocState> {
  SystemUsersBloc() : super(SystemUsersBlocInitial()) {
    final CloudAuth _service = CloudAuth();

    Future<void> onAddUser(AddNewUser event, emit) async {
      
      locator<AppDialogs>().showCostumTextLoading(
          event.context.translate.createing_new_user);

      // Simulating network request
      await Future.delayed(const Duration(seconds: 2));

      // add newuser locally ,
      final authed = locator<AuthedUser>();
      locator.unregister<AuthedUser>();
      final newData = {
        'users': [...authed.users, event.user],
      };
      locator.registerSingleton<AuthedUser>(authed.update(newData));

      _service.addNewUser(locator<AuthedUser>(), event.user, event.password);
      locator<AppDialogs>().disposeAnyActiveDialogs();
      GoRouter.of(event.context).pop();
      emit(AuthUpdated(locator<AuthedUser>()));
    }

    Future<void> onRemoveUser(DeleteUser event, emit) async {
      locator<AppDialogs>().showCostumTextLoading(
        event.context.translate.deleting,
      );

      // Simulating network request
      await Future.delayed(const Duration(seconds: 2));

      // add newuser locally ,
      final authed = locator<AuthedUser>();

      if (event.user.uid == authed.user.uid) {
        locator<AppDialogs>().disposeAnyActiveDialogs();
        showSnackBar(
            message: WarningSnackBar(
                title: event.context.translate.something_went_wrong,
                message: ""));
        return;
      }
      locator.unregister<AuthedUser>();
      List<User> newUsers = [];

      for (final user in authed.users) {
        if (user.uid != event.user.uid) {
          newUsers.add(user);
        }
      }
      final newData = {
        'users': newUsers,
      };

      locator.registerSingleton<AuthedUser>(authed.update(newData));
      locator<AppDialogs>().disposeAnyActiveDialogs();

      emit(AuthUpdated(locator<AuthedUser>()));
    }

    Future<void> onUpdateUser(UpdateUser event, emit) async {
      locator<AppDialogs>().showCostumTextLoading(
        event.context.translate.deleting,
      );

      // Simulating network request
      await Future.delayed(const Duration(seconds: 2));

      // add newuser locally ,
      final authed = locator<AuthedUser>();

      if (event.user.uid == authed.user.uid) {
        locator<AppDialogs>().disposeAnyActiveDialogs();
        return;
      }

      List<User> newUsers = [];

      for (final user in authed.users) {
        if (user.uid != event.user.uid) {
          newUsers.add(user);
        }
      }
      final newData = {
        'users': newUsers,
      };
      locator.unregister<AuthedUser>();
      locator.registerSingleton<AuthedUser>(authed.update(newData));
      locator<AppDialogs>().disposeAnyActiveDialogs();
      // GoRouter.of(locator<BuildContext>()).pop();
      emit(AuthUpdated(locator<AuthedUser>()));
    }

    // event listeners

    on<AddNewUser>(onAddUser);

    on<DeleteUser>(onRemoveUser);

    on<UpdateUser>(onUpdateUser);
  }
}
