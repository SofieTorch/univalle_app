import 'package:flutter/material.dart';
import 'package:univalle_app/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Text(l10n.navItemHome),
    );
  }
}
