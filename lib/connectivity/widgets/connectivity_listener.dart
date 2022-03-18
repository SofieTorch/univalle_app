import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:univalle_app/connectivity/connectivity.dart';

/// Listens for changes on ConnectvityBloc.
/// If connectivity is lost, displays a dialog informing of the situation,
/// if connectivity is retrieved after losing it, hides the dialog
/// and shows an informative snackbar.
class ConnectivityListener extends StatelessWidget {
  const ConnectivityListener({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state == ConnectivityState.disconnected) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: const ConnectivityLostDialog(),
              );
            },
          );
        }
        if (state == ConnectivityState.connected) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Conexión recuperada!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: child,
    );
  }
}
