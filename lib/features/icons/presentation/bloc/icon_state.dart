// lib/features/icons/presentation/bloc/icon_state.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/icon_entity.dart';

sealed class IconState extends Equatable {
  const IconState();

  @override
  List<Object?> get props => [];
}

class IconInitial extends IconState {
  const IconInitial();
}

class IconLoading extends IconState {
  const IconLoading();
}

class IconLoaded extends IconState {
  const IconLoaded(this.icons);

  final List<IconEntity> icons;

  @override
  List<Object?> get props => [icons];
}

class IconError extends IconState {
  const IconError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
