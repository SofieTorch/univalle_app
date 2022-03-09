part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent {
  const ConnectivityEvent();
}

class ConnectivityRequested extends ConnectivityEvent {
  const ConnectivityRequested();
}

class ConnectivityLost extends ConnectivityEvent {
  const ConnectivityLost();
}

class ConnectivityRetrieved extends ConnectivityEvent {
  const ConnectivityRetrieved();
}
