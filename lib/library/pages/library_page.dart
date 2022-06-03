import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/view/app.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LibraryView();
  }
}

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.libraryLoans);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('PRESTAMOS PENDIENTES'),
              Icon(MdiIcons.arrowRight),
            ],
          ),
        ),
      ),
    );
  }
}
