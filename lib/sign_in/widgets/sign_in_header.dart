import 'package:flutter/material.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/theme/theme.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Image.asset(
          'assets/images/univalle_logo.png',
          width: 164,
        ),
        Text(
          l10n.signInWelcomeHeader,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: AppColors.gray),
        ),
        Text(
          l10n.signInMessageHeader,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}
