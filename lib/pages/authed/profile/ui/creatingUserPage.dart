import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/profile/logic/systemUserBloc/system_users_bloc_bloc.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  bool isAdmin = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  late final TextEditingController _nameController ; 
  late final TextEditingController _usernameController ; 
  late final TextEditingController _passwordController ; 

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(); 
    _usernameController = TextEditingController(); 
    _passwordController = TextEditingController(); 
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose(); 
    _usernameController.dispose(); 
    _passwordController.dispose(); 

  }


  _onSave(){

    if(!_formKey.currentState!.validate()){
      return ; 
    }

    User newUser = User(
      username:  _usernameController.text,
      uid: "aks2-askdj-askj-alks", name: _nameController.text, admin: isAdmin); 

    context.read<SystemUsersBloc>().add(AddNewUser(user: newUser, password: _passwordController.text)); 

  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
          ),
          child: Column(
            children: [
              gap(height: AppPaddings.p30),
              Text(
                context.translate.create_new_user,
                style: textStyle.displayLarge!.copyWith(),
              ),
              gap(height: AppSizes.s30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // name field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: context.translate.name,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return context.translate.enter_name;
                        }
                        if (value.isEmpty) {
                          return context.translate.enter_name;
                        }
                        return null;
                      },
                    ),
                    gap(height: AppSizes.s10),
                    // username field
                    TextFormField(
                      controller: _usernameController,

                      decoration: InputDecoration(
                        hintText: context.translate.username,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return context.translate.enter_username;
                        }
                        if (value.isEmpty) {
                          return context.translate.enter_username;
                        }
                        for (final user in locator<AuthedUser>().users) {
                          if (user.name == value) {
                            return context.translate.username_is_taken;
                          }
                        }
                        return null;
                      },
                    ),
      
                    gap(height: AppSizes.s10),
                    // password field
                    TextFormField(
                      controller: _passwordController,

                      decoration: InputDecoration(
                        hintText: context.translate.password,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return context.translate.enter_password;
                        }
                        if (value.isEmpty) {
                          return context.translate.enter_username;
                        }
                        return null;
                      },
                    ),
      
                    gap(height: AppPaddings.p10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.translate.admin,
                          style: textStyle.displayMedium,
                        ),
                        CupertinoSwitch(
                          value: isAdmin,
                          onChanged: (value) {
                            setState(
                              () {
                                isAdmin = value;
                              },
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              gap(height: AppSizes.s50),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _onSave,
                      child: Text(
                        context.translate.save,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
