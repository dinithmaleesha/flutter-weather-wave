part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class ListenToConnectivityStatus extends ConnectivityEvent {}

class UpdateBluetoothStatus extends ConnectivityEvent {
  final bool isBluetoothOn;

  UpdateBluetoothStatus(this.isBluetoothOn);
}

class UpdateInternetStatus extends ConnectivityEvent {
  final bool hasInternet;

  UpdateInternetStatus(this.hasInternet);
}
class UpdateInitializedStatus extends ConnectivityEvent {
  final bool initialized;

  UpdateInitializedStatus(this.initialized);
}

class UpdateWifiStatus extends ConnectivityEvent {
  final bool isOn;

  UpdateWifiStatus(this.isOn);
}

class UpdateConnectionStatus extends ConnectivityEvent {
  final ConnectivityResult connection;

  UpdateConnectionStatus(this.connection);
}

class CheckInternetConnectivity extends ConnectivityEvent {}

