import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/router.dart';
import 'package:univalle_app/theme/theme.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
