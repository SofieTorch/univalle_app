part of 'place_list_bloc.dart';

abstract class PlaceListEvent extends Equatable {
  const PlaceListEvent();
}

class PlaceListRequested extends PlaceListEvent {
  const PlaceListRequested();

  @override
  List<Object> get props => [];
}
