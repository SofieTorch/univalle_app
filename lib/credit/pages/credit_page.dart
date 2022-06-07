import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/credit/widgets/credit_widget.dart';
import 'package:univalle_app/data/providers/payment_places_provider.dart';
import 'package:univalle_app/data/repositories/payment_places_repository.dart';
import 'package:univalle_app/payment_places/bloc/payment_places_bloc.dart';

class CreditPage extends StatelessWidget {
  const CreditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return const EnrollmentView();
    return BlocProvider<PaymentPlacesBloc>(
      create: (context) => PaymentPlacesBloc(
        paymentRepository: PaymentPlacesRepository(
          paymentPlacesProvider: PaymentPlacesProvider(),
        ),
      )..add(const PaymentListRequested()),
      child: const CreditView(),
    );
  }
}

class CreditView extends StatelessWidget {
  const CreditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentPlacesBloc, PaymentPlacesState>(
      builder: (context, state) {
        if (state.status == PaymentListRequestStatus.failure) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        if (state.status == PaymentListRequestStatus.success) {
          return const Credit();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
