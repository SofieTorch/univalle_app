import 'package:flutter/material.dart';
import 'package:univalle_app/credit/pages/credit_page.dart';
import 'package:univalle_app/enrollment/pages/enrollment_page.dart';
import 'package:univalle_app/payment_places/pages/payment_paces_page.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        //tu widget
        PaymentPage(),
        EnrollmentPage(),
        CreditPage(),
      ],
    );
  }
}
