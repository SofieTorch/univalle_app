import 'package:flutter/material.dart';
import 'package:univalle_app/credit/widgets/credit_widget.dart';

class CreditPage extends StatelessWidget {
  const CreditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return const EnrollmentView();
    return const CreditView();
  }
}

class CreditView extends StatelessWidget {
  const CreditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Credit();
  }
}
