import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_owner/pages/authed/profile/logic/systemUserBloc/system_users_bloc_bloc.dart';
import 'package:shop_owner/shared/UI/imageDisplayer.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late final TextEditingController _name;
  late final TextEditingController _password;
  Uint8List? _newProfile;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: locator<AuthedUser>().user.name);
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _password.dispose();
  }

  void onSave() {
    Map<String, String> data = {
      'name': _name.text,
    };
    if (_password.text.isNotEmpty) {
      data['password'] = _password.text;
    }
    context.read<SystemUsersBloc>().add(
          UpdateUser(
            imageUpdated: _newProfile != null,
            user: locator<AuthedUser>().user,
            updated: data,
            context: context,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
        child: Column(
          children: [
            gap(height: AppSizes.s30),

            GestureDetector(
              onTap: () async {
                // todo : navigate user to profile page
                final res = await pickImageFromGallery();
                if (res != null) {
                  setState(() {
                    _newProfile = res;
                  });
                }
              },
              child: Container(
                width: AppSizes.s200,
                height: AppSizes.s200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.s100),
                  border: Border.all(
                    color : AppColors.primary, 
                    width: AppSizes.s4, 
                    
                  )
                ),
                // this replace to actual user avatar if it necessary
                child: _newProfile == null
                    ? Image.asset(AssetPaths.user , fit: BoxFit.fill,)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.s100),
                        child: Image.memory(
                          _newProfile!,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),

            gap(height: AppSizes.s30),
            // name field
            TextField(
              controller: _name,
              decoration: InputDecoration(hintText: context.translate.name),
            ),
            gap(height: AppSizes.s10),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                hintText: context.translate.password,
              ),
            ),
            gap(height: AppSizes.s40),
            TextButton(
              onPressed: onSave,
              child: Text(context.translate.save),
            ),
            SizedBox(height: AppPaddings.p10),
          ],
        ),
      ),
    );
  }
}
