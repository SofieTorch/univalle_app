part of 'app.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (_) => NavigationCubit(),
      child: const _RootView(),
    );
  }
}

class _RootView extends StatelessWidget {
  const _RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.university)),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (_, state) {
          if (state is NavigationAcademic) return const HomePage();
          if (state is NavigationPayments) return const HomePage();
          if (state is NavigationProfile) return const HomePage();
          return const HomePage();
        },
      ),
    );
  }
}
