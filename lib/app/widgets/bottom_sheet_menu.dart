import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/view/app.dart';
import 'package:univalle_app/theme/theme.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({Key? key}) : super(key: key);

  void _navigateTo(String route, BuildContext context) {
    // Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Explora la biblioteca'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(MdiIcons.fileDocumentMultipleOutline),
          title: const Text('Revisa tus documentos'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(MdiIcons.clipboardTextClockOutline),
          title: const Text('Conoce los tipos de trámites'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(MdiIcons.ticketPercentOutline),
          title: const Text('Conoce tus descuentos'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(MdiIcons.map),
          title: const Text('Explora el campus'),
          onTap: () {},
        ),
      ],
    );
  }
}
