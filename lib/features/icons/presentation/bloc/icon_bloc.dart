// lib/features/icons/presentation/bloc/icon_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_dynamic_icons_use_case.dart';
import 'icon_event.dart';
import 'icon_state.dart';

class IconBloc extends Bloc<IconEvent, IconState> {
  IconBloc(this._getDynamicIcons) : super(const IconInitial()) {
    on<FetchIcons>(_onFetchIcons);
  }

  final GetDynamicIconsUseCase _getDynamicIcons;

  Future<void> _onFetchIcons(
    FetchIcons event,
    Emitter<IconState> emit,
  ) async {
    emit(const IconLoading());
    try {
      final icons = await _getDynamicIcons();
      emit(IconLoaded(icons));
    } catch (error) {
      emit(IconError(error.toString()));
    }
  }
}
