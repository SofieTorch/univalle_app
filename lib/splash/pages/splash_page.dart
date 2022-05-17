import 'package:flutter/material.dart';
import 'package:univalle_app/theme/theme.dart';

/// Splash Material App, which will be shown while the
/// main app is initializing, as a Splash page.
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: const SplashView(),
    );
  }
}

/// Splash view, shown as the default root for the main app.
/// Also used on Splash Page as its content.
class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
