import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/view/app.dart';
import 'package:univalle_app/l10n/l10n.dart';

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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.libraryPageAppBarTitle),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.libraryLoans);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.libraryPageLoansButtonText),
              const Icon(MdiIcons.arrowRight),
            ],
          ),
        ),
      ),
    );
  }
}
