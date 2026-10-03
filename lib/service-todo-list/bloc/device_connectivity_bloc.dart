import 'dart:async';

import 'device_connectivity_well.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ToDoConnectivityBloc
    extends Bloc<ToDoConnectivityEvent, ToDoConnectivityState> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  ToDoConnectivityBloc() : super(ToDoIsDisconnected()) {
    on<ToDoConnected>((event, emit) => emit(ToDoIsConnected()));
    on<ToDoDisconnected>((event, emit) => emit(ToDoIsDisconnected()));
    _startConnectivityService();
  }

  void _startConnectivityService() {
    _initialConnectivityCheck();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      add(_getEventFromResult(results.firstOrNull));
    });
  }

  void _initialConnectivityCheck() async {
    // This will add the initial result in the stream
    final initialConnectivityResult =
        (await Connectivity().checkConnectivity()).firstOrNull;
    if (!isClosed) {
      add(_getEventFromResult(initialConnectivityResult));
    }
  }

  // Convert from the third part enum to our own enum
  ToDoConnectivityEvent _getEventFromResult(ConnectivityResult? result) {
    return result == null || result == ConnectivityResult.none
        ? ToDoDisconnected()
        : ToDoConnected();
  }

  @override
  Future<void> close() async {
    await _connectivitySubscription?.cancel();
    return super.close();
  }
}
