import 'package:flutter/material.dart';
import 'package:univalle_app/theme/app_colors.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.shiraz.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
