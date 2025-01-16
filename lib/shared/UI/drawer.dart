import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/shared/UI/languageListTile.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/style/theme/logic/bloc/them_bloc_bloc.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

Widget appDrawer(BuildContext context) {
  final textStyle = Theme.of(context).textTheme;
  // get proper height for drawer 
  double preferredHeight = 650; // or more..
  // get screen height
  double screenHeight = MediaQuery.of(context).size.height;

  if(screenHeight > preferredHeight){
    preferredHeight = screenHeight;
  }

  return SizedBox(
    height: screenHeight,
    child: SingleChildScrollView(
      child: ConstrainedBox(
         constraints: BoxConstraints(
            maxHeight: preferredHeight,
          ),
        child: Drawer(
          child: Column(
            children: [
              // top gap
              Expanded(
                flex: 1,
                child: Container(),
              ),
              
              // prfile section
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    // todo : navigate user to profile page
                  },
                  child: Column(
                    children: [
                      // avatar
                      Expanded(
                        flex: 5,
                        child: CircleAvatar(
                          radius: AppSizes.infinity,
                          // this replace to actual user avatar if it necessary
                          child: Image.asset(AssetPaths.user),
                        ),
                      ),
              
                      // name
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            locator<User>().name,
                            style: textStyle.displayLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // list tiles
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    // app theme mode
                    ListTile(
                      leading: Text(
                        context.translate.light_mode,
                        style: textStyle.displayLarge,
                      ),
                      trailing: CupertinoSwitch(
                        value: Theme.of(context).brightness == Brightness.light,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) => context
                            .read<ThemeBloc>()
                            .add(ChangeTheme(context: context)),
                      ),
                    ),
              
                    // app language
                    const LanguageListTile()
                  ],
                ),
              ),
              // logout section
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.s20),
                      width: AppSizes.infinity,
                      height: AppSizes.s50,
                      child: TextButton(
                        onPressed: () {
                          locator<AppDialogs>().showLogoutConfiramtion();
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(AppColors.error),
                        ),
                        child: Text(
                          context.translate.sign_out,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // trailing gap
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    ),
  );
}
