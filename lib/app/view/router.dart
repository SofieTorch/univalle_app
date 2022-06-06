part of 'app.dart';

/// Manages app routes and bloc providers needed through
/// all the application.
class AppRouter {
  final ConnectivityBloc connectivityBloc = ConnectivityBloc(Connectivity());

  static const String home = '/';
  static const String signIn = '/signin';
  static const String procedures = '/procedures';
  static const String library = '/library';
  static const String libraryResults = '/library/results';
  static const String libraryLoans = '/library/loans';
  static const String book = '/book';
  static const String discounts = '/discounts';
  static const String documents = '/documents';
  static const String places = '/places';
  static const String splash = '/splash';

  /// Maps a given route to its corresponding page, initializing
  /// the necessary bloc providers for the page.
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signIn:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: SignInPage()),
            );
          },
        );
      case procedures:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: ProceduresPage()),
            );
          },
        );
      case library:
        return MaterialPageRoute<Widget>(
          settings: routeSettings,
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: LibraryPage()),
            );
          },
        );
      case libraryResults:
        final bloc = routeSettings.arguments! as LibrarySearchBloc;
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ConnectivityBloc>.value(
                  value: connectivityBloc..add(const ConnectivityRequested()),
                ),
                BlocProvider<LibrarySearchBloc>.value(
                  value: bloc,
                ),
              ],
              child: const ConnectivityListener(
                child: LibrarySearchResultsPage(),
              ),
            );
          },
        );
      case libraryLoans:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: LibraryLoansPage()),
            );
          },
        );
      case book:
        final book = routeSettings.arguments! as Book;
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BookDetailPage(book);
          },
        );
      case discounts:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: DiscountsPage()),
            );
          },
        );
      case documents:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: DocumentsPage()),
            );
          },
        );
      case places:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: CampusPlacesPage()),
            );
          },
        );
      case splash:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: SplashView()),
            );
          },
        );
      case home:
      default:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return BlocProvider<ConnectivityBloc>.value(
              value: connectivityBloc..add(const ConnectivityRequested()),
              child: const ConnectivityListener(child: RootPage()),
            );
          },
        );
    }
  }

  void dispose() {
    connectivityBloc.close();
  }
}
