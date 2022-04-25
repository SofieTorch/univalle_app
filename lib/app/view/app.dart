import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univalle_app/app/navigation/navigation.dart';
import 'package:univalle_app/app/widgets/widgets.dart';
import 'package:univalle_app/authentication/authentication.dart';
import 'package:univalle_app/connectivity/connectivity.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/procedures/procedures.dart';
import 'package:univalle_app/sign_in/sign_in.dart';
import 'package:univalle_app/splash/splash.dart';
import 'package:univalle_app/theme/theme.dart';

part 'root_page.dart';
part 'router.dart';

// ignore: must_be_immutable
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  late StorageProvider _storageProvider;
  late AuthenticationRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (_, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          _storageProvider = StorageProvider(prefs: snapshot.data!);
          _authRepository = AuthenticationRepository(prefs: _storageProvider);

          return RepositoryProvider.value(
            value: _authRepository,
            child: BlocProvider<AuthenticationBloc>(
              create: (_) => AuthenticationBloc(
                authRepository: _authRepository,
              )..add(AuthenticationRequested()),
              child: const _AppView(),
            ),
          );
        }
        return const SplashPage();
      },
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({Key? key}) : super(key: key);

  @override
  State<_AppView> createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  final AppRouter _router = AppRouter();
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: _router.onGenerateRoute,
      initialRoute: AppRouter.splash,
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  AppRouter.home,
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  AppRouter.signIn,
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
