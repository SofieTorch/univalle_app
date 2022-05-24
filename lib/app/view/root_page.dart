part of 'app.dart';

/// The main widget for the app, besides MaterialApp.
/// Initializes the navigation management with the [Navigation Cubit]
/// and provides it to its view, [_RootView].
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

/// The main view for the app,
/// contains the needed structure to navigate through
/// the app and visualize pages.
/// Listens to [NavigationCubit] for navigation management
/// on bottom navigation bar.
class _RootView extends StatelessWidget {
  const _RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (_, state) {
          if (state is NavigationAcademic) return const AcademicPage();
          if (state is NavigationPayments) return const HomePage();
          if (state is NavigationProfile) return const HomePage();
          return const HomePage();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      foregroundColor: AppColors.shiraz,
      iconTheme: Theme.of(context)
          .appBarTheme
          .iconTheme
          ?.copyWith(color: AppColors.shiraz),
      title: Row(
        children: [
          const Icon(AppIcons.university),
          const SizedBox(width: 8),
          Text(l10n.university),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: const Icon(MdiIcons.menu),
            onPressed: () => showModalBottomSheet<Widget>(
              context: context,
              builder: (_) => const BottomSheetMenu(),
            ),
          ),
        ),
      ],
    );
  }
}
