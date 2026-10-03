import 'package:bloc/bloc.dart';

import 'todo_apptab_states.dart';
import 'todo_apptab_events.dart';

class ToDoTabBloc extends Bloc<ToDoTabEvent, ToDoAppTab> {
  ToDoTabBloc() : super(ToDoAppTab.allToDos) {
    on<ToDoTabUpdated>((event, emit) => emit(event.tab));
  }
}
