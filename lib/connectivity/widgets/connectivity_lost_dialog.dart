import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The dialog displayed when internet connection is lost.
/// Locks the app while it is visible, so the app can only
/// be used when there is an available internet connection.
class ConnectivityLostDialog extends StatelessWidget {
  const ConnectivityLostDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: SvgPicture.asset(
                'assets/illustrations/lost_connection.svg',
                semanticsLabel: 'Sin conexión',
                // width: 200,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '¡Ups! Te quedaste sin conexión 🙁',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
