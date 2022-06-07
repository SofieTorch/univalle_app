import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/environment.dart';
import 'package:univalle_app/models/payment_places.dart';
import 'package:univalle_app/payment_places/bloc/payment_places_bloc.dart';
import 'package:univalle_app/payment_places/widgets/cubit/payment_item_cubit.dart';
import 'package:univalle_app/theme/app_colors.dart';

class PaymentPlaces extends StatelessWidget {
  const PaymentPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentItemCubit(),
      child: const PaymentPlacesView(),
    );
  }
}

class PaymentPlacesView extends StatelessWidget {
  const PaymentPlacesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showPayments = context.select<PaymentItemCubit, bool>(
      (value) => value.state.showPayments,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos de Interés',
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            children: [
              Text(
                'Lugares de pago',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColors.matterhorn),
              ),
              //button to display the list payment places
              ElevatedButton(
                onPressed: () {
                  context
                      .read<PaymentItemCubit>()
                      .changeRequirementsVisibility();
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.white,
                  padding: const EdgeInsets.all(1),
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  showPayments ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                  size: 20,
                  color: AppColors.matterhorn,
                ),
              ),
            ],
          ),
          //const SizedBox(height: 2),
          if (showPayments) const BancosList(),
        ],
      ),
    );
  }
}

class BancosList extends StatelessWidget {
  const BancosList({Key? key}) : super(key: key);
  //final PaymentsPlaces type;
  @override
  Widget build(BuildContext context) {
    final payments = context.read<PaymentPlacesBloc>().state.paymentplaces;

    //Implementacion
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Chip(
              label: Text(
                'Bancos',
                style: Theme.of(context).textTheme.overline,
              ),
              backgroundColor: AppColors.shiraz.shade100,
            ),
            Chip(
              label: Text(
                'Cajas',
                style: Theme.of(context).textTheme.overline,
              ),
              backgroundColor: AppColors.gray.shade200,
            ),
          ],
        ),
        const SizedBox(height: 4),
        ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          itemCount: payments.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final paymentPlace = payments[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 30,
                      child: Image.network(payments[index].logoImageUrl),
                    ),
                    const SizedBox(width: 5),
                    Text(payments[index].name),
                  ],
                ),
                Text(paymentPlace.type.join(', ')),
              ],
            );
          },
        ),
      ],
    );
  }
}
