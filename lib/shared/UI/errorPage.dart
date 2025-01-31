import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10,
        ),
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(flex: 4, child: Image.asset(AssetPaths.sorry)),
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  context.translate.something_went_wrong,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).go(AppRoutes.home);
                      },
                      child:  Text(
                        context.translate.go_home,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
