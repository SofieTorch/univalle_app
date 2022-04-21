import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/navigation/navigation.dart';
import 'package:univalle_app/l10n/l10n.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(MdiIcons.homeVariantOutline),
          label: l10n.navItemHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(MdiIcons.school),
          label: l10n.navItemAcademic,
        ),
        BottomNavigationBarItem(
          icon: const Icon(MdiIcons.cashMultiple),
          label: l10n.navItemPayments,
        ),
        BottomNavigationBarItem(
          icon: const Icon(MdiIcons.accountCircle),
          label: l10n.navItemProfile,
        ),
      ],
      onTap: context.read<NavigationCubit>().changePage,
      currentIndex: context.select(
        (NavigationCubit cubit) => cubit.state.index,
      ),
    );
  }
}
