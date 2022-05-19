import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/profile/profile.dart';
import 'package:univalle_app/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ProfileView();
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          padding: const EdgeInsets.all(16),
          height: double.infinity,
          color: const Color.fromARGB(66, 255, 255, 255),
          child: ListView(
            shrinkWrap: true,
            primary: true,
            children: [
              const UserHeader(),
              ListView(
                shrinkWrap: true,
                children: const <Widget>[
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading: Icon(MdiIcons.at, size: 25),
                        minLeadingWidth: 10,
                        title: Text(
                          'uom0028814@est.univalle.edu',
                          style: TextStyle(fontSize: 15),
                        ),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading:
                            Icon(MdiIcons.cityVariantOutline, size: 25),
                        minLeadingWidth: 10,
                        title: Text('Sede Cochabamba',
                            style: TextStyle(fontSize: 15)),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading:
                            const Icon(MdiIcons.accountChildOutline, size: 25),
                        minLeadingWidth: 10,
                        title: Text('Apoderado: Carla Usieda Soria',
                            style: TextStyle(fontSize: 15)),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading: const Icon(MdiIcons.calendarToday, size: 25),
                        minLeadingWidth: 10,
                        title: Text('Nacido/a el 09/07/2002',
                            style: TextStyle(fontSize: 15)),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading:
                            const Icon(MdiIcons.genderMaleFemale, size: 25),
                        minLeadingWidth: 10,
                        title: Text('Sexo masculino',
                            style: TextStyle(fontSize: 15)),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading: Icon(MdiIcons.earth, size: 25),
                        minLeadingWidth: 10,
                        title: Text('País: Bolivia',
                            style: TextStyle(fontSize: 15)),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                    ListTile(
                        leading: Icon(MdiIcons.logout,
                            size: 25, color: AppColors.shiraz),
                        minLeadingWidth: 10,
                        title: Text(
                          'Cerrar Sesion',
                          style:
                              TextStyle(fontSize: 15, color: AppColors.shiraz),
                        ),
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4)),
                    Divider(height: 10, thickness: 0.7),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
