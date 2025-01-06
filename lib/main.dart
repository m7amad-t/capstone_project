import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_owner/l10n/kurdish_cupertino_localization_deligate.dart';
import 'package:shop_owner/l10n/kurdish_material_localization_delegate.dart';
import 'package:shop_owner/l10n/kurdish_widget_localization_deligate.dart';
import 'package:shop_owner/l10n/l10n.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/bloc/cart_bloc_bloc.dart';
import 'package:shop_owner/pages/notAuthed/login/logic/bloc/login_bloc_bloc.dart';
import 'package:shop_owner/router/appRouter.dart';
import 'package:shop_owner/style/languages/logic/bloc/language_bloc_bloc.dart';
import 'package:shop_owner/style/theme/darkTheme.dart';
import 'package:shop_owner/style/theme/lightTheme.dart';
import 'package:shop_owner/style/theme/logic/bloc/them_bloc_bloc.dart';
import 'package:shop_owner/utils/auth/bloc/auth_bloc_bloc.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // create a storage for hydrated bloc
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // sign the storage..
  HydratedBloc.storage = storage;

  setUpLocator();

  runApp(
    // toastification wraper , use for in toasts(snackbar)
    ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LoginBloc(),
          ),
          BlocProvider(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider(
            create: (_) => LanguageBloc(),
          ),
          BlocProvider(
            create: (_) => ProductBloc(),
          ),
          BlocProvider(
            create: (_) => AuthBloc(),
          ),
          BlocProvider(
            create: (_) => CartBloc(),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter().router;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeBlocState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageBloc, LanguageBlocState>(
          builder: (context, languageState) {
            setupAppDynamicSizes(context);

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: lightModeThemeData(languageState.local),
              darkTheme: darkModeThemeData(languageState.local),
              themeMode: themeState.mode,
              supportedLocales: L10n.all,
              locale: languageState.local,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
                KurdishMaterialLocalizations.delegate,
                KurdishWidgetLocalizations.delegate,
                KurdishCupertinoLocalizations.delegate,
              ],
              routerConfig: _router,
            );


          
          },
        );
      },
    );
  }
}
