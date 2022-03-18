part of 'connectivity_bloc.dart';

/// Base class for Connectivity Bloc Events.
abstract class ConnectivityEvent {
  const ConnectivityEvent();
}

/// Indicates that a listening request of
/// connectivity changes was sent.
class ConnectivityRequested extends ConnectivityEvent {
  const ConnectivityRequested();
}

/// Indicates that the internet connection
/// has been lost, so it is unavailable.
class ConnectivityLost extends ConnectivityEvent {
  const ConnectivityLost();
}

/// Indicates that the internet connection
/// has been retrieved, so it is available.
class ConnectivityRetrieved extends ConnectivityEvent {
  const ConnectivityRetrieved();
}
