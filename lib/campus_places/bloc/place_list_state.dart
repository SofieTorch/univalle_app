part of 'place_list_bloc.dart';

enum PlaceListRequestStatus { initial, loading, success, failure }

class PlaceListState extends Equatable {
  const PlaceListState({
    this.status = PlaceListRequestStatus.initial,
    this.otherPlaces = const {},
    this.errorMessage = '',
    this.ownPlaces = const [],
    this.ownHeadquarter = Headquarter.empty,
  });

  final PlaceListRequestStatus status;
  final List<Place> ownPlaces;
  final Headquarter ownHeadquarter;
  final Map<Headquarter, List<Place>> otherPlaces;
  final String errorMessage;

  PlaceListState copyWith({
    PlaceListRequestStatus? status,
    Map<Headquarter, List<Place>>? otherPlaces,
    String? errorMessage,
    List<Place>? ownPlaces,
    Headquarter? ownHeadquarter,
  }) {
    return PlaceListState(
      status: status ?? this.status,
      otherPlaces: otherPlaces ?? this.otherPlaces,
      errorMessage: errorMessage ?? this.errorMessage,
      ownPlaces: ownPlaces ?? this.ownPlaces,
      ownHeadquarter: ownHeadquarter ?? this.ownHeadquarter,
    );
  }

  @override
  List<Object> get props => [status, otherPlaces, errorMessage];
}
