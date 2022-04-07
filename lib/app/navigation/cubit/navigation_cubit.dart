import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationHome());

  void changePage(int index) {
    if (index == 0) emit(const NavigationHome());
    if (index == 1) emit(const NavigationAcademic());
    if (index == 2) emit(const NavigationPayments());
    if (index == 3) emit(const NavigationProfile());
  }
}
