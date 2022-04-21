import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/view/app.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/theme/theme.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({Key? key}) : super(key: key);

  void _navigateTo(String route, BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            color: AppColors.gray.shade400,
          ),
          width: 44,
          height: 3,
        ),
        ListTile(
          leading: const Icon(MdiIcons.bookEducationOutline),
          title: Text(l10n.menuItemLibrary),
        ),
        ListTile(
          leading: const Icon(MdiIcons.fileDocumentMultipleOutline),
          title: Text(l10n.menuItemDocuments),
        ),
        ListTile(
          leading: const Icon(MdiIcons.clipboardTextClockOutline),
          title: Text(l10n.menuItemProcedures),
          onTap: () => _navigateTo(AppRouter.procedures, context),
        ),
        ListTile(
          leading: const Icon(MdiIcons.ticketPercentOutline),
          title: Text(l10n.menuItemDiscounts),
        ),
        ListTile(
          leading: const Icon(MdiIcons.map),
          title: Text(l10n.menuItemCampus),
        ),
      ],
    );
  }
}
