import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/connectivity/connectivity.dart';
import 'package:univalle_app/home/pages/home_page.dart';
import 'package:univalle_app/log_in/log_in.dart';

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
              child: const ConnectivityListener(child: HomePage()),
            );
          },
        );
    }
  }

  void dispose() {
    connectivityBloc.close();
  }
}
