import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:univalle_app/l10n/l10n.dart';

class NoEnrolledMessage extends StatelessWidget {
  const NoEnrolledMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 32,
        left: 32,
        right: 32,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: SvgPicture.asset(
                  'assets/illustrations/join.svg',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.noEnrolledMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
