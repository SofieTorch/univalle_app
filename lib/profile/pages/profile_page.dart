import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/profile/bloc/students_bloc.dart';
import 'package:univalle_app/profile/profile.dart';
import 'package:univalle_app/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsBloc>(
      create: (context) => StudentsBloc(
        studentRepository: StudentRepository(
          storageProvider: context.read<StorageProvider>(),
        ),
      )..add(StudentsRequested()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<StudentsBloc, StudentsState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              primary: true,
              children: const [UserHeader(), UserListView()],
            );
          },
        ),
      ),
    );
  }
}
