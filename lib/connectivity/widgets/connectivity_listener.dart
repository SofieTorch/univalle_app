import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:univalle_app/connectivity/connectivity.dart';

class ConnectivityListener extends StatelessWidget {
  const ConnectivityListener({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        print(Navigator.canPop(context));
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
