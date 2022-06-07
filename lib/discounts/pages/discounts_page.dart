import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/discounts/discounts.dart';

class DiscountsPage extends StatelessWidget {
  const DiscountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscountListBloc>(
      create: (context) => DiscountListBloc(
        discountsRepository: DiscountsRepository(
          discountsProvider: DiscountsProvider(),
        ),
      )..add(const DiscountListRequested()),
      child: const DiscountView(),
    );
  }
}

class DiscountView extends StatelessWidget {
  const DiscountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis descuentos'),
      ),
      body: BlocBuilder<DiscountListBloc, DiscountListState>(
        builder: (context, state) {
          if (state.status == DiscountListRequestStatus.failure) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          if (state.status == DiscountListRequestStatus.success) {
            return DiscountsTabsView(state.discounts);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
