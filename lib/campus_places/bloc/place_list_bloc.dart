import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/models.dart';

part 'place_list_event.dart';
part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  PlaceListBloc({
    required CampusRepository campusRepository,
    required StorageProvider storageProvider,
  })  : _repository = campusRepository,
        _storageProvider = storageProvider,
        super(const PlaceListState()) {
    on<PlaceListRequested>(_onPlaceListRequested);
  }

  final CampusRepository _repository;
  final StorageProvider _storageProvider;

  Future<void> _onPlaceListRequested(
    PlaceListRequested event,
    Emitter<PlaceListState> emit,
  ) async {
    emit(state.copyWith(status: PlaceListRequestStatus.loading));

    try {
      final places = await _repository.getPlaces();
      final ownHeadquarter = places.keys.firstWhere(
        (h) => h.id == _storageProvider.headquarter,
      );
      final ownPlaces = places[ownHeadquarter];
      places.removeWhere((key, value) => key == ownHeadquarter);

      emit(
        state.copyWith(
          status: PlaceListRequestStatus.success,
          otherPlaces: places,
          ownHeadquarter: ownHeadquarter,
          ownPlaces: ownPlaces,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PlaceListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
