import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/profile/logic/systemUserBloc/system_users_bloc_bloc.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/blocs/currencyBloc/currency_bloc_bloc.dart';
import 'package:shop_owner/shared/models/storeCurrency.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late AuthedUser authedModel;
  late STORE_CURRENCY currency;
  @override
  void initState() {
    super.initState();
    user = locator<AuthedUser>().user;
    authedModel = locator<AuthedUser>();
    currency = authedModel.currency;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context)
              .go("${AppRoutes.profile}/${AppRoutes.updateProfile}");
        },
        child: const Icon(
          Icons.edit_note_rounded,
          color: AppColors.onPrimary,
          size: AppSizes.s30,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
        child: Column(
          children: [
            // top gap
            gap(height: AppSizes.s30),

            // hero
            CircleAvatar(
              radius: AppSizes.s80,
              // this replace to actual user avatar if it necessary
              child: Image.asset(AssetPaths.user),
            ),

            gap(height: AppSizes.s30),
            BlocBuilder<SystemUsersBloc, SystemUsersBlocState>(
              builder: (context, state) {
                user = locator<AuthedUser>().user;
                return Text(user.name, style: textStyle.titleMedium);
              },
            ),
            gap(height: AppSizes.s60),

            _currencySection(),

            gap(height: AppPaddings.p30),

            if (user.admin) _onlyAdminSection(textStyle),
          ],
        ),
      ),
    );
  }

  Widget _onlyAdminSection(TextTheme textStyle) {
    return Column(
      children: [
        Text(
          context.translate.system_users,
          style: textStyle.displayMedium,
        ),
        Divider(
          height: AppSizes.s10,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context)
                      .go(AppRoutes.profile + "/" + AppRoutes.addUser);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_add,
                      color: AppColors.onPrimary,
                      size: AppSizes.s26,
                    ),
                    gap(width: AppSizes.s10),
                    Text(context.translate.create_new_user),
                  ],
                ),
              ),
            ),
          ],
        ),
        gap(height: AppPaddings.p10),
        _usersSection(),

        // trailling gap
        gap(height: AppSizes.s150),
      ],
    );
  }

  Widget _currencySection() {
    return BlocBuilder<CurrencyBloc, CurrencyBlocState>(
      builder: (context, state) {
        authedModel = locator<AuthedUser>();

        final textStyle = TextTheme.of(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.translate.store_currency, style: textStyle.bodyLarge),
            gap(width: AppSizes.s10),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.s10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.s8),
                border: Border.all(
                  color: AppColors.primary,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<STORE_CURRENCY>(
                  iconEnabledColor: AppColors.primary,
                  value: authedModel.currency,
                  items: [
                    for (final currency in STORE_CURRENCY_LIST)
                      DropdownMenuItem(
                        value: currency,
                        child: SizedBox(
                          width: AppSizes.s120,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  currency.name1(context),
                                  style: textStyle.bodyMedium,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  currency.sign,
                                  style: textStyle.bodyMedium!.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    currency = value;
                    context.read<CurrencyBloc>().add(
                        ChangeCurrency(context: context, newCurrency: value));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _usersSection() {
    return BlocBuilder<SystemUsersBloc, SystemUsersBlocState>(
      builder: (context, state) {
        authedModel = locator<AuthedUser>();
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: authedModel.users.length,
          itemBuilder: (context, index) {
            if (authedModel.users[index].uid == user.uid) {
              return SizedBox.shrink();
            }
            final textStyle = TextTheme.of(context);
            return users(authedModel.users[index], textStyle, context.fromLTR)
                .paddingOnly(bottom: AppPaddings.p10);
          },
        );
      },
    );
  }

  Widget users(User user, TextTheme textStyle, bool isLTR) {
    return InkWell(
      onLongPress: () {
        locator<AppDialogs>().showDeleteUserconfirmation(user: user);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10,
          vertical: AppPaddings.p16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSizes.s8,
          ),
          color: AppColors.primary.withAlpha(100),
        ),
        child: isLTR
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Icon(
                      user.admin ? Icons.person : Icons.person_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        user.name,
                        style: textStyle.bodyMedium!.copyWith(
                          color: AppColors.primary,
                        ),
                      )),
                  Expanded(
                      child: Text(
                    user.admin
                        ? context.translate.admin
                        : context.translate.employee,
                    style: textStyle.bodyMedium!.copyWith(
                      color: AppColors.primary,
                    ),
                  )),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      user.admin
                          ? context.translate.admin
                          : context.translate.employee,
                      textAlign: TextAlign.left,
                      style: textStyle.bodyMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.name,
                      textAlign: TextAlign.left,
                      style: textStyle.bodyMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Icon(
                      user.admin ? Icons.person : Icons.person_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
