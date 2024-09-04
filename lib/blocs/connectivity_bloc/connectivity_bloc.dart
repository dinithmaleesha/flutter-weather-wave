import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';


part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityState.initial()) {
    on<ListenToConnectivityStatus>(_onListenToConnectivityStatus);
    on<UpdateWifiStatus>(_onUpdateWifiStatus);
    on<UpdateInternetStatus>(_onUpdateInternetStatus);
    on<UpdateConnectionStatus>(_onUpdateConnectionStatus);
    on<UpdateBluetoothStatus>(_onUpdateBluetoothStatus);
    on<CheckInternetConnectivity>(_onCheckInternetConnectivity);
    on<UpdateInitializedStatus>(_onUpdateInitializedStatus);
    add(ListenToConnectivityStatus());
  }

  StreamSubscription? _connectivity;

  bool isInitial = true;

  Future<void> _onListenToConnectivityStatus(
      ListenToConnectivityStatus event,
      emit,
      ) async {
    bool isWarningShowed =false;
    _connectivity ??=
        Connectivity().onConnectivityChanged.listen((status) async {
          add(UpdateWifiStatus(status == ConnectivityResult.wifi));
          bool hasInternet = await ConnectivityWrapper.instance.isConnected;
          add(UpdateInternetStatus(hasInternet));
          add(UpdateConnectionStatus(status));

          if (state.initialized && hasInternet) {
            print("Network connection restored.",);
            isWarningShowed=false;
          } else if (!hasInternet) {
            print("No internet.");
            if(!isWarningShowed) {
              //PopupHandler.showNoInternetConnectivityDialog();
            }
            isWarningShowed=true;
          }
        });
    add(UpdateInitializedStatus(true));
    isInitial = false;
    isWarningShowed=false;
  }

  Future<void> _onUpdateWifiStatus(
      UpdateWifiStatus event,
      emit,
      ) async {
    emit(state.copyWith(isWifiOn: event.isOn));
  }

  Future<void> _onUpdateBluetoothStatus(
      UpdateBluetoothStatus event,
      emit,
      ) async {
    emit(state.copyWith(isBluetoothOn: event.isBluetoothOn));
  }

  Future<void> _onUpdateInternetStatus(
      UpdateInternetStatus event,
      emit,
      ) async {
    emit(state.copyWith(hasInternet: event.hasInternet));
  }

  Future<void> _onUpdateInitializedStatus(
      UpdateInitializedStatus event,
      emit,
      ) async {
    emit(state.copyWith(initialized: event.initialized));
  }

  Future<void> _onUpdateConnectionStatus(
      UpdateConnectionStatus event,
      emit,
      ) async {
    emit(state.copyWith(connection: event.connection));
  }

  Future<void> _onCheckInternetConnectivity(
      CheckInternetConnectivity event,
      emit,
      ) async {
    bool hasInternet = await ConnectivityWrapper.instance.isConnected;
    if (!hasInternet) {
      print("No internet.");
    }
  }

  @override
  Future<void> close() {
    _connectivity?.cancel();
    return super.close();
  }
}
