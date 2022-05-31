import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:univalle_app/l10n/l10n.dart';

/// Message to inform the user is not currently enrolled
/// in the university.
///
/// Used, for example, when the user is trying to retrieve
/// its subjects, schedule, etc. but is not enrolled.
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
