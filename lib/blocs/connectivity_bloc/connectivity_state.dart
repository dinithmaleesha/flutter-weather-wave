part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  ConnectivityState({
    required this.isBluetoothOn,
    required this.hasInternet,
    required this.isWifiOn,
    required this.connection,
    required this.initialized
  });

  final bool isBluetoothOn;
  final bool hasInternet;
  final bool isWifiOn;
  final ConnectivityResult connection;
  final bool initialized;

  factory ConnectivityState.initial() {
    return ConnectivityState(
      isBluetoothOn: false,
      hasInternet: false,
      isWifiOn: false,
      connection: ConnectivityResult.none,
      initialized: false
    );
  }

  ConnectivityState copyWith({
    bool? isBluetoothOn,
    bool? hasInternet,
    bool? isWifiOn,
    ConnectivityResult? connection,
    bool? initialized
  }) {
    return ConnectivityState(
      isBluetoothOn: isBluetoothOn ?? this.isBluetoothOn,
      hasInternet: hasInternet ?? this.hasInternet,
      isWifiOn: isWifiOn ?? this.isWifiOn,
      connection: connection ?? this.connection,
      initialized: initialized ?? this.initialized,
    );
  }

  @override
  List<Object?> get props => [
    isBluetoothOn,
    hasInternet,
    isWifiOn,
    connection,
    initialized
  ];
}