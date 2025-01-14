// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/notAuthed/login/logic/bloc/login_bloc_bloc.dart';
import 'package:shop_owner/pages/notAuthed/login/logic/model/loginModel.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // username textField
  late final TextEditingController _usernameTEC;

  // password textField
  late final TextEditingController _passwordTEC;

  // function to validate username
  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return context.translate.enter_username;
    }
    return null;
  }

  // function to validate password
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return context.translate.enter_password;
    }
    return null;
  }

  void _validate() {
    if (_formKey.currentState!.validate()) {
      final LoginModel model = LoginModel(
        username: _usernameTEC.text,
        password: _passwordTEC.text,
      );
      context.read<LoginBloc>().add(Login(context: context, model: model));
      return;
    }
  }

  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    _usernameTEC = TextEditingController();
    _passwordTEC = TextEditingController();
    setupAppDialogs(context); 
  }

  @override
  void dispose() {
    _usernameTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _textStyles = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.sign_in),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
            vertical: AppPaddings.p16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // hero
                Image.asset(
                  AssetPaths.loginImage,
                  width: locator<DynamicSizes>().p70,
                ),
                // welcome back text
                Text(
                  context.translate.welcome_back,
                  style: _textStyles.titleLarge,
                ),
    
                // virtical gap
                gap(height: 20),
    
                // login form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // username textForm field
                      TextFormField(
                        controller: _usernameTEC,
                        style: _textStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: context.translate.username,
                        ),
                        validator: _usernameValidator,
                      ),
    
                      // virtical gap
                      gap(height: 10),
                      // password textForm field
                      Stack(
                        children: [
                          TextFormField(
                            controller: _passwordTEC,
                            obscureText: _showPassword,
                            style: _textStyles.bodyLarge,
                            decoration: InputDecoration(
                              hintText: context.translate.password,
                            ),
                            validator: _passwordValidator,
                          ),
                          Positioned(
                            // bottom: 0,
                            top: AppSizes.s2,
                            right:
                                Localizations.localeOf(context).toString() ==
                                        'en'
                                    ? 10
                                    : null,
                            left:
                                Localizations.localeOf(context).toString() !=
                                        'en'
                                    ? 10
                                    : null,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(
                                _showPassword
                                    ? Icons.remove_red_eye
                                    : Icons.lock,
                              ),
                            ),
                          ),
                        ],
                      ),
    
                      // virtical gap
                      gap(height: 10),
    
                      // login button
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: _validate,
                              child: Text(
                                context.translate.sign_in,
                                style: _textStyles.displayLarge!.copyWith(
                                  color: AppColors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
