part of 'app.dart';

/// Manages app routes and bloc providers needed through
/// all the application.
class AppRouter {
  final ConnectivityBloc connectivityBloc = ConnectivityBloc(Connectivity());

  static const String home = '/';
  static const String logIn = '/login';
  static const String procedures = '/procedures';

  /// Maps a given route to its corresponding page, initializing
  /// the necessary bloc providers for the page.
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouter.logIn:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: LogInPage()),
            );
          },
        );
      case AppRouter.procedures:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: ProceduresPage()),
            );
          },
        );
      case AppRouter.home:
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
