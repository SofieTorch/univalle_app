part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityLost extends ConnectivityEvent {
  const ConnectivityLost();
}

class ConnectivityRetrieved extends ConnectivityEvent {
  const ConnectivityRetrieved();
}
