import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/models/schedule.dart';
import 'package:univalle_app/schedule/schedule.dart';

class MockScheduleRepository extends Mock implements ScheduleRepository {}

class MockSchedule extends Mock implements Schedule {}

void main() {
  group('Schedule bloc', () {
    late MockScheduleRepository mockScheduleRepository;
    late MockSchedule mockSchedule;

    setUp(() {
      mockScheduleRepository = MockScheduleRepository();
      mockSchedule = MockSchedule();
    });

    test(
      'Initial state is [ScheduleState()]',
      () {
        expect(
          ScheduleBloc(scheduleRepository: mockScheduleRepository).state,
          equals(const ScheduleState()),
        );
      },
    );

    blocTest<ScheduleBloc, ScheduleState>(
      '''
      emits [
        ScheduleState(
          status: ScheduleRequestStatus.loading,
        ),
        ScheduleState(
          status: ScheduleRequestStatus.success,
          schedule: mockSchedule,
        ),
      ] when ScheduleRequested() is added and
      ScheduleRepository returns schedule successfully.
      ''',
      setUp: () {
        when(() => mockScheduleRepository.getSchedule())
            .thenAnswer((_) => Future<Schedule>(() => mockSchedule));
      },
      build: () => ScheduleBloc(scheduleRepository: mockScheduleRepository),
      act: (bloc) => bloc.add(const ScheduleRequested()),
      expect: () => <ScheduleState>[
        const ScheduleState(
          status: ScheduleRequestStatus.loading,
        ),
        ScheduleState(
          status: ScheduleRequestStatus.success,
          schedule: mockSchedule,
        ),
      ],
    );

    blocTest<ScheduleBloc, ScheduleState>(
      '''
      emits [
        ScheduleState(
          status: ScheduleRequestStatus.loading,
        ),
        ScheduleState(
          status: ScheduleRequestStatus.failure,
          schedule: <error message>,
        ),
      ] when ScheduleRequested() is added and
      ScheduleRepository throws an error.
      ''',
      setUp: () {
        when(() => mockScheduleRepository.getSchedule())
            .thenThrow(Exception('test error message'));
      },
      build: () => ScheduleBloc(scheduleRepository: mockScheduleRepository),
      act: (bloc) => bloc.add(const ScheduleRequested()),
      expect: () => const <ScheduleState>[
        ScheduleState(
          status: ScheduleRequestStatus.loading,
        ),
        ScheduleState(
          status: ScheduleRequestStatus.failure,
          errorMessage: 'Exception: test error message',
        ),
      ],
      verify: (bloc) {
        verify(() => mockScheduleRepository.getSchedule()).called(1);
        expect(bloc.state.schedule.scheduleMap, isEmpty);
      },
    );
  });
}
