import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/app_colors.dart';
import 'package:univalle_app/theme/app_text_style.dart';

class MonthlyFees extends StatelessWidget {
  const MonthlyFees(this.index, this.fees, {Key? key}) : super(key: key);

  final Fees fees;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      title: Transform.translate(
        offset: const Offset(-16, 0),
        child: Text(
          'Cuota # $index',
          style: GoogleFonts.nunitoSans(
            textStyle: AppTextStyle.subtitle1,
            fontSize: 18,
          ),
        ),
      ),
      subtitle: Transform.translate(
        offset: const Offset(-16, 0),
        child: Text(
          'Vence el ${fees.expirationDate}',
          style: GoogleFonts.nunitoSans(
            textStyle: AppTextStyle.caption,
            fontSize: 13,
          ),
        ),
      ),
      trailing: Text(
        '${fees.price}.00 Bs',
        style: GoogleFonts.nunitoSans(
          fontSize: 18,
          textStyle: AppTextStyle.overline,
        ),
      ),
    );
  }
}
