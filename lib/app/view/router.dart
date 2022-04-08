part of 'app.dart';

class AppRouter {
  final ConnectivityBloc connectivityBloc = ConnectivityBloc(Connectivity());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: LogInPage()),
            );
          },
        );
      case '/':
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
