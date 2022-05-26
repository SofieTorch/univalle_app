import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/profile/bloc/students_bloc.dart';
import 'package:univalle_app/theme/app_colors.dart';

import '../../data/providers/providers.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = context.read<StudentsBloc>().state.student;
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.at, size: 25),
            minLeadingWidth: 10,
            title: Text(
              student.mail,
              style: TextStyle(fontSize: 15),
            ),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.cityVariantOutline, size: 25),
            minLeadingWidth: 10,
            title:
                Text('Sede ${student.country}', style: TextStyle(fontSize: 15)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.accountChildOutline, size: 25),
            minLeadingWidth: 10,
            title: Text('Apoderado: ${student.representative}',
                style: TextStyle(fontSize: 15)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.calendarToday, size: 25),
            minLeadingWidth: 10,
            title:
                Text('Nacido/a el 09/07/2002', style: TextStyle(fontSize: 15)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.genderMaleFemale, size: 25),
            minLeadingWidth: 10,
            title: Text('Sexo ${student.sex}', style: TextStyle(fontSize: 15)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.earth, size: 25),
            minLeadingWidth: 10,
            title: Text('País: ${student.country}',
                style: TextStyle(fontSize: 15)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
        ListTile(
            leading: Icon(MdiIcons.logout, size: 25, color: AppColors.shiraz),
            minLeadingWidth: 10,
            title: Text(
              'Cerrar Sesion',
              style: TextStyle(fontSize: 15, color: AppColors.shiraz),
            ),
            dense: true,
            visualDensity: VisualDensity(vertical: -4)),
        Divider(height: 10, thickness: 0.7),
      ],
    );
  }
}
