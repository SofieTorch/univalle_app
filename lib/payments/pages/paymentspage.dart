import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/credit/pages/credit_page.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/enrollment/pages/enrollment_page.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/payment_places/pages/payment_paces_page.dart';
import 'package:univalle_app/payments/payments_fees_bloc/payments_fees_bloc.dart';
import 'package:univalle_app/payments/payments_places_bloc/payment_places_bloc.dart';
import 'package:univalle_app/payments/widgets/widgets.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<PaymentPlacesBloc>(
        //   create: (context) => PaymentPlacesBloc(
        //     paymentRepository: PaymentPlacesRepository(
        //       paymentPlacesProvider: PaymentPlacesProvider(),
        //     ),
        //   )..add(const PaymentListRequested()),
        // ),
        BlocProvider<PaymentsFeesBloc>(
          create: (context) => PaymentsFeesBloc(
            paymentsFeesRepository: PaymentsFeesRepository(
              paymentsFeesProvider: PaymentsFeesProvider(
                storageProvider: context.read<StorageProvider>(),
              ),
            ),
          )..add(PaymentsFeesRequested()),
        ),
      ],
      child: const PaymentView(),
    );
  }
}

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<PaymentsFeesBloc, PaymentsFeesState>(
                builder: (context, state) {
                  if (state.status == PaymentsRequestStatus.failure) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }

                  if (state.status == PaymentsRequestStatus.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pagos pendientes',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (state.fees.isEmpty)
                          const AlertMessage('No tienes pagos pendientes')
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.fees.length,
                            itemBuilder: (_, index) =>
                                MonthlyFees(index, state.fees[index]),
                            separatorBuilder: (_, __) => const Divider(),
                          )
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Datos de Interés',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              const PaymentPage(),
              const EnrollmentPage(),
              const CreditPage(),
            ],
          ),
        ),
      ),
    );
  }
}
