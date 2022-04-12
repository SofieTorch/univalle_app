import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

/// Manages navigation state for the main pages:
/// Home, Academic, Payments and Profile.
///
/// Currently used on RootPage, for its bottom navigation bar.
/// Emits a [NavigationState].
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationHome());

  /// Maps an index to a state which reflect a page.
  ///
  /// So far there is only four pages,
  /// so the index should be between 0 and 3.
  void changePage(int index) {
    if (index == 0) emit(const NavigationHome());
    if (index == 1) emit(const NavigationAcademic());
    if (index == 2) emit(const NavigationPayments());
    if (index == 3) emit(const NavigationProfile());
  }
}
