import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/app/navigation/navigation.dart';

void main() {
  group('Bottom navigation bar cubit test', () {
    test('Initial state is [NavigationHome].', () {
      expect(NavigationCubit().state, const NavigationHome());
    });

    blocTest<NavigationCubit, NavigationState>(
      'emits [NavigationAcademic] when changePage(1) is invoked.',
      build: NavigationCubit.new,
      act: (cubit) => cubit.changePage(1),
      expect: () => const <NavigationState>[NavigationAcademic()],
    );

    blocTest<NavigationCubit, NavigationState>(
      'emits [NavigationPayments] when changePage(2) is invoked.',
      build: NavigationCubit.new,
      act: (cubit) => cubit.changePage(2),
      expect: () => const <NavigationState>[NavigationPayments()],
    );

    blocTest<NavigationCubit, NavigationState>(
      'emits [NavigationProfile] when changePage(3) is invoked.',
      build: NavigationCubit.new,
      act: (cubit) => cubit.changePage(3),
      expect: () => const <NavigationState>[NavigationProfile()],
    );

    blocTest<NavigationCubit, NavigationState>(
      '''
        emits [NavigationAcademic, NavigationHome]
        when changePage(1) and changePage(0) is invoked.
      ''',
      build: NavigationCubit.new,
      act: (cubit) => cubit
        ..changePage(1)
        ..changePage(0),
      expect: () => const <NavigationState>[
        NavigationAcademic(),
        NavigationHome(),
      ],
    );
  });
}
