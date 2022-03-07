import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:univalle_app/connectivity/connectivity.dart';

class ConnectivityListener extends StatelessWidget {
  const ConnectivityListener({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    BuildContext? dialogContext;

    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state == ConnectivityState.disconnected) {
          showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              dialogContext = context;
              return WillPopScope(
                onWillPop: () async => false,
                child: const ConnectivityLostDialog(),
              );
            },
          );
        }
        if (state == ConnectivityState.connected) {
          if (dialogContext != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Conexión recuperada!'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(dialogContext!, true);
          }
        }
      },
      child: child,
    );
  }
}
