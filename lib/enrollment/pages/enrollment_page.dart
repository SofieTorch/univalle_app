import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/payment_places_provider.dart';
import 'package:univalle_app/data/repositories/payment_places_repository.dart';
import 'package:univalle_app/enrollment/widgets/enrollment_widget.dart';
import 'package:univalle_app/payment_places/bloc/payment_places_bloc.dart';

class EnrollmentPage extends StatelessWidget {
  const EnrollmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EnrollmentView();
  }
}

class EnrollmentView extends StatelessWidget {
  const EnrollmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Enrollment();
  }
}
