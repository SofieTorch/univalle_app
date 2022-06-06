import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/campus_places/campus_places.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/theme/theme.dart';

class CampusPlacesPage extends StatelessWidget {
  const CampusPlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlaceListBloc>(
      create: (context) => PlaceListBloc(
        campusRepository: CampusRepository(
          campusProvider: CampusProvider(),
        ),
        storageProvider: context.read<StorageProvider>(),
      )..add(const PlaceListRequested()),
      child: const CampusPlacesView(),
    );
  }
}

class CampusPlacesView extends StatelessWidget {
  const CampusPlacesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.campusPlacesPageAppBar)),
      body: BlocBuilder<PlaceListBloc, PlaceListState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == PlaceListRequestStatus.failure) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          if (state.status == PlaceListRequestStatus.success) {
            return ListView(
              padding: const EdgeInsets.all(16),
              primary: true,
              children: [
                Text(
                  l10n.campusPlacesOwnHeadquarterLabel,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  '${l10n.headquarterLabel} ${state.ownHeadquarter.department}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColors.gray),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.ownPlaces.length,
                    itemBuilder: (_, index) {
                      return LargePlaceCard(state.ownPlaces[index]);
                    },
                    separatorBuilder: (_, index) => const SizedBox(width: 16),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.campusPlacesOthersHeadquartersLabel,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 8),
                const HeadquartersTabView(),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
