import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/service-todo-list/bloc/device_connectivity_bloc.dart';
import 'package:flutter_application_1/service-todo-list/bloc/device_connectivity_states.dart';

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ToDoConnectivityBloc(),
      child: BlocBuilder<ToDoConnectivityBloc, ToDoConnectivityState>(
        builder: (context, state) => Icon(
          state is ToDoIsConnected ? Icons.wifi : Icons.signal_wifi_off,
          color: state is ToDoIsConnected
              ? Colors.lightGreenAccent
              : Colors.grey,
        ),
      ),
    );
  }
}
