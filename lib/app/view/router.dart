part of 'app.dart';

/// Manages app routes and bloc providers needed through
/// all the application.
class AppRouter {
  final ConnectivityBloc connectivityBloc = ConnectivityBloc(Connectivity());

  static const String home = '/';
  static const String signIn = '/signin';
  static const String procedures = '/procedures';
  static const String splash = '/splash';

  /// Maps a given route to its corresponding page, initializing
  /// the necessary bloc providers for the page.
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signIn:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: SignInPage()),
            );
          },
        );
      case procedures:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: ProceduresPage()),
            );
          },
        );
      case splash:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: SplashView()),
            );
          },
        );
      case home:
      default:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: RootPage()),
            );
          },
        );
    }
  }

  void dispose() {
    connectivityBloc.close();
  }
}
