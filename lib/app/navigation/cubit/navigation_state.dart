part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}

class NavigationHome extends NavigationState {
  const NavigationHome() : super(0);
}

class NavigationAcademic extends NavigationState {
  const NavigationAcademic() : super(1);
}

class NavigationPayments extends NavigationState {
  const NavigationPayments() : super(2);
}

class NavigationProfile extends NavigationState {
  const NavigationProfile() : super(3);
}
