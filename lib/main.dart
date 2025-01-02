import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_owner/l10n/kurdish_cupertino_localization_deligate.dart';
import 'package:shop_owner/l10n/kurdish_material_localization_delegate.dart';
import 'package:shop_owner/l10n/kurdish_widget_localization_deligate.dart';
import 'package:shop_owner/l10n/l10n.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/expensesTrackingPage.dart';
import 'package:shop_owner/pages/authed/home/ui/homePage.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/productManagementPage.dart';
import 'package:shop_owner/pages/authed/profile/ui/profilepage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/saleAnalyticsPage.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/saleTrackingPage.dart';
import 'package:shop_owner/pages/authed/settings/ui/settingPage.dart';
import 'package:shop_owner/pages/notAuthed/login/logic/bloc/login_bloc_bloc.dart';
import 'package:shop_owner/pages/notAuthed/login/ui/loginPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shop_owner/router/routes.dart';
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
            create: (_) => AuthBloc()..add(AuthUser()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeBlocState>(
          builder: (context, themeState) {
            return BlocBuilder<LanguageBloc, LanguageBlocState>(
              builder: (context, languageState) {
                // init di service
                setUpLocator(context);

                return MaterialApp(
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
                  routes: {
                    AppRoutes.home: (context) => const HomePage(),
                    AppRoutes.login: (context) => const LoginPage(),
                    AppRoutes.saleTracking: (context) =>
                        const SaleTrackingPage(),
                    AppRoutes.saleAnalytics: (context) =>
                        const SaleAnalyticPage(),
                    AppRoutes.productManagement: (context) =>
                        const ProductManagementPage(),
                    AppRoutes.expensesTracking: (context) =>
                        const ExpensesTracking(),
                    AppRoutes.profile: (context) => const ProfilePage(),
                    AppRoutes.settings: (context) => const SettingPage(),

                    // add more routes here
                  },
                  home: const App(),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}

// app wraper for authentication
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(
      buildWhen: (oldState, newState) {
        if (newState is Loading && oldState is InitAuthState) {
          return true;
        }

        if (newState is Loading && oldState is! Loading) {
          return false;
        }
        return oldState != newState;
      },
      builder: (context, state) {
        if (state is UserAuthed) {
          return const HomePage();
        } else if (state is FailedToAuth || state is LoggedOut) {
          return const LoginPage();
        }
        return Scaffold(
          body: Center(
            child: Text(
              "ArchiTechIraq",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        );
      },
    );
  }
}
