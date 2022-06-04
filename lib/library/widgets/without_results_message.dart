import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WithoutResultsMessage extends StatelessWidget {
  const WithoutResultsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 58,
        left: 58,
        right: 58,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: SvgPicture.asset(
                  'assets/illustrations/not_found.svg',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Sin resultados',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
