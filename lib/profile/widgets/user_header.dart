import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/profile/bloc/students_bloc.dart';
import 'package:univalle_app/theme/app_colors.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = context.read<StudentsBloc>().state.student;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.shiraz.shade200,
            radius: 72,
            child: CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(student.imageUrl),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            student.fullName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: AppColors.shiraz.shade100,
            ),
            child: Text(student.career),
          ),
        ],
      ),
    );
  }
}
